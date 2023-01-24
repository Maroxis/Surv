extends ProcessingFood

onready var output_item: Control = $"%OutputItem"
onready var food_select: Control = $"%FoodSelect"
onready var rack: TextureProgress = $"%Rack"
onready var time_remaining: Label = $"%TimeRemaining"
onready var warning: Panel = $"%Warning"

signal dryProgress

func _ready() -> void:
	Global.Drying = self
	for food in Inventory.food:
		if Inventory.food[food].has("dryable") and Inventory.food[food]["dryable"]:
			food_select.add_item(food)
	food_select.init()
	output_item.init("DriedMeat",true)
	rack.value = 0

func pack():
	var data = {}
	data["timeLeft"] = timeLeft
	data["timeTotal"] = timeTotal
	data["dryAmm"] = processAmm
	data["dryingItem"] = processingItem
	return data

func unpack(data):
	if data.has("timeLeft"):
		timeLeft = int(data["timeLeft"])
	if data.has("timeTotal"):
		timeTotal = int(data["timeTotal"])
	if data.has("dryAmm"):
		processAmm = int(data["dryAmm"])
	if data.has("dryingItem"):
		processingItem = String(data["dryingItem"])

func refresh():
	var showWarning = Buildings.getTierInt("Workbench","DryingRack") == 0
	warning.visible = showWarning
	changeAmm(rawAmm)
	food_select.refreshAmmBar(selectedItem)
	refreshProgress()

func refreshProgress():
	if timeTotal == 0:
		return
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	var val = float(timeLeft)/float(timeTotal) * 100
	rack.value = val
	emit_signal("dryProgress",val)

func changeAmm(amm):
	rawAmm = amm
	var cookTime = Inventory.food[selectedItem]["dryTime"] * amm
	output_item.changeAmm(amm * Inventory.food[selectedItem]["dryMult"])
	if(timeLeft == 0):
		time_remaining.text = Global.timeGetFullFormat(cookTime,false,true) 

func start():
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
	Inventory.add_resource(selectedItem,-rawAmm,true)
	timeLeft = Inventory.food[selectedItem]["dryTime"] * rawAmm
	timeTotal = timeLeft
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	processAmm = rawAmm * Inventory.food[selectedItem]["dryMult"]
	processingItem = Inventory.food[selectedItem]["driesInto"]
	food_select.changeMaxAmm(Inventory.get_food_amm(selectedItem))
	refreshProgress()

func atemptStart() -> void:
	if(timeLeft != 0 or rawAmm == 0):
		output_item.shakeSubtleSide()
		return
	output_item.shakeSubtle()
	start()

func _on_OutputItem_itemClicked(_item) -> void:
	atemptStart()
