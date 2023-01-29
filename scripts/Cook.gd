extends ProcessingFood

onready var item_select: Control = $"%FoodSelect"
onready var flame: TextureProgress = $"%Flame"
onready var time_remaining: Label = $"%TimeRemaining"
onready var fuel: Control = $"%Fuel"

onready var selected_fuel = null
onready var fuelRequired = 0

signal cookProgress

func _ready() -> void:
	Global.Cook = self
	sound = Sound.UI_COOK_LOOP
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
	data["cookAmm"] = processAmm
	data["cookingItem"] = processingItem
	return data

func unpack(data):
	if data.has("timeLeft"):
		timeLeft = int(data["timeLeft"])
	if data.has("timeTotal"):
		timeTotal = int(data["timeTotal"])
	if data.has("cookAmm"):
		processAmm = int(data["cookAmm"])
	if data.has("cookingItem"):
		processingItem = String(data["cookingItem"])

func refresh():
	changeAmm(rawAmm)
	item_select.refreshAmmBar(selectedItem)
	refreshProgress()

func refreshProgress():
	flame.material.set_shader_param("on",1.0)
	if timeTotal == 0:
		flame.material.set_shader_param("on",0.0)
		return
	if timeLeft == 0:
		flame.material.set_shader_param("on",0.0)
	else:
		Global.Sound.play_loop(Sound.UI_COOK_LOOP, "SFX_LOOP_GLOBAL")
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	var val = float(timeLeft)/float(timeTotal) * 100
	flame.value = val
	emit_signal("cookProgress",val)

func changeAmm(amm):
	rawAmm = amm
	var fuelItems = fuel.get_children()
	var cookTime = Inventory.food[selectedItem]["cookTime"] * amm
	for fuelItem in fuelItems:
		var fuelAmm = ceil(cookTime / Inventory.resources[fuelItem.item]["burining"]["time"])
		fuelItem.changeAmm(fuelAmm)
	if(timeLeft == 0):
		time_remaining.text = Global.timeGetFullFormat(cookTime,false,true) 

func start():
	Inventory.add_resource(selected_fuel,-fuelRequired)
	Inventory.add_resource(selectedItem,-rawAmm,true)
	timeLeft = Inventory.food[selectedItem]["cookTime"] * rawAmm
	timeTotal = timeLeft
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	processAmm = rawAmm
	processingItem = Inventory.food[selectedItem]["cooksInto"]
	item_select.changeMaxAmm(Inventory.get_food_amm(selectedItem))
	refreshProgress()
	Global.Sound.play_loop(Sound.UI_COOK_LOOP, "SFX_LOOP_GLOBAL")

func attemptStart() -> void:
	fuelRequired = ceil(Inventory.food[selectedItem]["cookTime"] * rawAmm / Inventory.resources[selected_fuel]["burining"]["time"])
	if(timeLeft != 0 or fuelRequired == 0 or fuelRequired > Inventory.get_res_amm(selected_fuel)):
		fuel.shakeSelectedSide()
		return
	fuel.shakeSelected()
	start()

func _on_Fuel_itemClicked(item) -> void:
	selected_fuel = item
	attemptStart()
