extends "res://scripts/BaseActivity.gd"

onready var item_select: Control = $"%FoodSelect"
onready var flame: TextureProgress = $"%Flame"
onready var time_remaining: Label = $"%TimeRemaining"
onready var fuel: Control = $"%Fuel"
onready var food_label: Label = $"%FoodLabel"

onready var selectedItem = "Blank"
onready var cookingItem = "Blank"
onready var selected_fuel = null
onready var fuelRequired = 0
onready var rawAmm = 0
onready var cookAmm = 0
onready var timeLeft = 0
onready var timeTotal = 0

signal cookProgress

func _ready() -> void:
	Global.Cook = self
	for food in Inventory.food:
		if Inventory.food[food].has("cookable") and Inventory.food[food]["cookable"]:
			item_select.add_item(food)
	item_select.init()
	flame.value = 0
	fuel.addItem("Stick")
	fuel.addItem("Wood")

func pack():
	var data = {}
	data["timeLeft"] = timeLeft
	data["timeTotal"] = timeTotal
	data["cookAmm"] = cookAmm
	data["cookingItem"] = cookingItem
	return data

func unpack(data):
	timeLeft = int(data["timeLeft"])
	timeTotal = int(data["timeTotal"])
	cookAmm = int(data["cookAmm"])
	cookingItem = String(data["cookingItem"])

func refresh():
	changeAmm(rawAmm)
	item_select.refreshAmmBar(selectedItem)
	refreshProgress()

func refreshProgress():
	if timeTotal == 0:
		return
	if timeLeft == 0:
		flame.material.set_shader_param("on",0.0)
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	var val = float(timeLeft)/float(timeTotal) * 100
	flame.value = val
	emit_signal("cookProgress",val)
	flame.material.set_shader_param("on",1.0)

func selectItem(item):
	selectedItem = item
	food_label.text = item

func changeAmm(amm):
	rawAmm = amm
	var fuelItems = fuel.get_children()
	var cookTime = Inventory.food[selectedItem]["cookTime"] * amm
	for fuelItem in fuelItems:
		var fuelAmm = ceil(cookTime / Inventory.resources[fuelItem.item]["burining"]["time"])
		fuelItem.changeAmm(fuelAmm)
	if(timeLeft == 0):
		time_remaining.text = Global.timeGetFullFormat(cookTime,false,true) 

func run(time):
	if(timeLeft > 0):
		var roofed = Buildings.getCurrentModule("House","Roof")["benefits"]["roofed"]
		var raining = Global.Weather.getRainInt() > 0
		if(raining and not roofed):
			return
		else:
			timeLeft -= time
			if(timeLeft <= 0):
				timeLeft = 0
			if(timeLeft == 0):
				finish()
			refreshProgress()

func finish():
	Inventory.add_resource(cookingItem,cookAmm,true)
	refreshProgress()

func start():
	Inventory.add_resource(selected_fuel,-fuelRequired)
	Inventory.add_resource(selectedItem,-rawAmm,true)
	timeLeft = Inventory.food[selectedItem]["cookTime"] * rawAmm
	timeTotal = timeLeft
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	cookAmm = rawAmm
	cookingItem = Inventory.food[selectedItem]["cooksInto"]
	item_select.changeMaxAmm(Inventory.get_food_amm(selectedItem))
	refreshProgress()

func attemptStart() -> void:
	fuelRequired = ceil(Inventory.food[selectedItem]["cookTime"] * rawAmm / Inventory.resources[selected_fuel]["burining"]["time"])
	if(timeLeft != 0 or fuelRequired == 0 or fuelRequired > Inventory.get_res_amm(selected_fuel)):
		fuel.shakeSelected()
		return
	start()

func _on_Fuel_itemClicked(item) -> void:
	selected_fuel = item
	attemptStart()

func _on_FoodSelect_ammChanged(amm) -> void:
	changeAmm(amm)

func _on_FoodSelect_itemSelected(item) -> void:
	selectItem(item)
