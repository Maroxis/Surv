extends Control

onready var timeRemainingLabel: Label = $"%TimeLabel"
onready var furnaceProgress: TextureProgress = $"%Progress"
onready var recipe_select: Control = $"%RecipeSelect"
onready var fuel_select: VBoxContainer = $"%FuelSelect"
onready var ore_required: VBoxContainer = $"%OreRequired"
onready var item_scene  = load("res://nodes/components/ItemSquareAmm.tscn")
onready var recipe_label: Label = $"%RecipeLabel"
onready var warning: Panel = $"%Warning"
onready var furnace: VBoxContainer = $"%Furnace"

onready var basicFuelEfficency = 2
onready var timeTotal = 0
onready var timeLeft = 0
var selectedRecipe
var selectedFuel
var smeltingRecipe

signal furnaceProgress

func _ready() -> void:
	Global.Smelt = self
	addItems()
	selectRecipe(selectedRecipe)
	furnace.curPos.x = furnace.rect_position.x

func refresh():
	var showWarning = Buildings.getTierInt("Furnace","Oven") == 0
	warning.visible = showWarning
	if(timeTotal == 0):
		return
	timeRemainingLabel.text = Global.timeGetFullFormat(timeLeft,false,true) 
	var val = float(timeLeft)/float(timeTotal) * 100
	furnaceProgress.value = val
	emit_signal("furnaceProgress",val)
	if timeLeft == 0:
		furnaceProgress.material.set_shader_param("on",0.0)
	else:
		furnaceProgress.material.set_shader_param("on",1.0)

func pack():
	var data = {}
	data["timeTotal"] = timeTotal
	data["timeLeft"] = timeLeft
	data["smeltingRecipe"] = smeltingRecipe
	return data

func unpack(data):
	if data.has("timeTotal"):
		timeTotal = data["timeTotal"]
	if data.has("timeLeft"):
		timeLeft = data["timeLeft"]
	if data.has("smeltingRecipe"):
		smeltingRecipe = data["smeltingRecipe"]

func addItems():
	for res in Inventory.resources:
		if Inventory.resources[res].has("furnaceTier"):
			recipe_select.add_item(res)
	recipe_select.init()
	fuel_select.addItem("Wood")
	fuel_select.addItem("Coal")

func run(time):
	if(timeLeft > 0):
		timeLeft -= time
		if(timeLeft <= 0):
			timeLeft = 0
		refresh()
		if(timeLeft == 0):
			finish()
#
func finish():
	Inventory.add_resource(smeltingRecipe,1)
	furnaceProgress.material.set_shader_param("on",0.0)

func start():
	emit_signal("furnaceProgress",100)
	var time = getCraftTime()
	timeTotal = time
	timeLeft = time
	removeRes()
	smeltingRecipe = selectedRecipe
	timeRemainingLabel.text = Global.timeGetFullFormat(time,false,true) 
	furnaceProgress.value = 100
	furnaceProgress.material.set_shader_param("on",1.0)

func getCraftTime():
	var time = Inventory.resources[selectedRecipe]["craftTime"]
	time *= Buildings.getCurrentModule("Furnace","Bellows")["benefits"]["timeMult"]
	return time

func getFuelEfficency():
	return basicFuelEfficency
	
func removeRes():
	Inventory.craft_item(selectedRecipe,1,false)
	Inventory.add_resource(selectedFuel,-getFuelAmm())

func clearList(list):
	for n in list.get_children():
		n.queue_free()

func getFuelAmm(fuel = null):
	if not fuel:
		fuel = selectedFuel
	return int(ceil(Inventory.resources[selectedRecipe]["craftTime"]/(Inventory.resources[fuel]["burining"]["time"]*getFuelEfficency())))

func calcFuel():
	for fuel in fuel_select.get_children():
		var amm = getFuelAmm(fuel.name)
		fuel.changeAmm(amm)
		fuel.toggle(Inventory.resources[fuel.item]["burining"]["temp"] >= Inventory.resources[selectedRecipe]["meltingTemp"])

func selectRecipe(item):
	selectedRecipe = item
	recipe_label.text = item
	clearList(ore_required)
	for res in Inventory.resources[item]["cost"]:
		var scene_instance = item_scene.instance()
		ore_required.add_child(scene_instance)
		scene_instance.init(res)
		var amm = Inventory.resources[item]["cost"][res]
		scene_instance.changeAmm(amm)
	calcFuel()
	if timeLeft == 0:
		timeRemainingLabel.text = Global.timeGetFullFormat(getCraftTime(),false,true)

func checkOre():
	var index = 0
	for ore in Inventory.resources[selectedRecipe]["cost"]:
		if(Inventory.resources[selectedRecipe]["cost"][ore] > Inventory.get_res_amm(ore)):
			ore_required.get_children()[index].shakeSide()
			return false
		index += 1
	return true

func checkFurnace():
	var ctier = Buildings.getTierInt("Furnace","Oven")
	var rtier = Inventory.resources[selectedRecipe]["furnaceTier"]
	if ctier < rtier:
		timeRemainingLabel.text = "Upgrade Furnace"
		furnace.shakeSide()
		return false
	return true

func _on_RecipeSelect_itemSelected(item) -> void:
	selectRecipe(item)

func _on_FuelSelect_itemClicked(item) -> void:
	if(timeLeft > 0):
		return
	selectedFuel = item
	var amm = getFuelAmm()
	if(amm > Inventory.get_res_amm(item)):
		fuel_select.shakeSelected()
	elif(checkOre() and checkFurnace()):
		start()
