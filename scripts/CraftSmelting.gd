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
onready var itemAmm = 1
var selectedRecipe
var selectedFuel
var selectedAmm
var smeltingRecipe

signal furnaceProgress

func _ready() -> void:
	Global.Smelt = self
	addItems()
	selectRecipe(selectedRecipe)
	furnace.curPos.x = furnace.rect_position.x
	recipe_select.changeAmm(1)

func refresh():
	changeSliderMaxAmm()
	var showWarning = Buildings.getTierInt("Furnace","Oven") == 0
	warning.visible = showWarning
	recipe_select.toggleSlider(Buildings.getTierInt("Furnace","Oven") > 1)
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
	data["selectedAmm"] = selectedAmm
	return data

func unpack(data):
	if data.has("timeTotal"):
		timeTotal = data["timeTotal"]
	if data.has("timeLeft"):
		timeLeft = data["timeLeft"]
	if data.has("smeltingRecipe"):
		smeltingRecipe = data["smeltingRecipe"]
	if data.has("selectedAmm"):
		selectedAmm = data["selectedAmm"]

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

func finish():
	Inventory.add_resource(smeltingRecipe,selectedAmm)
	furnaceProgress.material.set_shader_param("on",0.0)

func start():
	emit_signal("furnaceProgress",100)
	var time = getCraftTime()
	timeTotal = time
	timeLeft = time
	selectedAmm = itemAmm
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
	return float(basicFuelEfficency * Buildings.getCurrentModule("Furnace","Oven")["benefits"]["fuelEff"])
	
func removeRes():
	Inventory.craft_item(selectedRecipe,selectedAmm,false)
	Inventory.add_resource(selectedFuel,-getFuelAmm())

func clearList(list):
	for n in list.get_children():
		n.queue_free()

func getFuelAmm(fuel = null):
	if not fuel:
		fuel = selectedFuel
	var amm = ceil((Inventory.resources[selectedRecipe]["craftTime"]*itemAmm)/(Inventory.resources[fuel]["burining"]["time"]*getFuelEfficency()))
	return int(amm)

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
		var amm = Inventory.resources[item]["cost"][res]*itemAmm
		scene_instance.changeAmm(amm)
	calcFuel()
	if timeLeft == 0:
		timeRemainingLabel.text = Global.timeGetFullFormat(getCraftTime(),false,true)

func changeAmm(amm):
	itemAmm = max(amm,1)
	selectRecipe(selectedRecipe)

func checkOre():
	var index = 0
	for ore in Inventory.resources[selectedRecipe]["cost"]:
		if(Inventory.resources[selectedRecipe]["cost"][ore]*itemAmm > Inventory.get_res_amm(ore)):
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

func changeSliderMaxAmm():
	var mxamm = Buildings.getCurrentModule("Furnace","Oven")["benefits"]["multiSmelt"]
	recipe_select.changeMaxAmm(mxamm)

func _on_RecipeSelect_itemSelected(item) -> void:
	selectedRecipe = item
	changeSliderMaxAmm()
	selectRecipe(selectedRecipe)

func _on_FuelSelect_itemClicked(item) -> void:
	if(timeLeft > 0):
		return
	selectedFuel = item
	var amm = getFuelAmm()
	if(amm > Inventory.get_res_amm(item)):
		fuel_select.shakeSelectedSide()
	elif(checkOre() and checkFurnace()):
		fuel_select.shakeSelected()
		start()


func _on_RecipeSelect_ammChanged(amm) -> void:
	changeAmm(amm)
