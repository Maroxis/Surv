extends "res://scripts/BaseActivity.gd"

onready var item_select: Control = $HBoxContainer/FoodSelect/ItemSelectWAmm
onready var flame: TextureProgress = $HBoxContainer/Progress/VBoxContainer/Flame
onready var start_button: Button = $"%StartButton"
onready var fuel_ammount: Label = $HBoxContainer/Info/HBoxContainer/Fuel/Ammount
onready var time_remaining: Label = $HBoxContainer/Progress/VBoxContainer/TimeRemaining

onready var selectedItem = "Blank"
onready var cookingItem = "Blank"
onready var fuelRequired = 0
onready var rawAmm = 0
onready var cookAmm = 0
onready var timeLeft = 0
onready var timeTotal = 0

func _ready() -> void:
	Global.Cook = self
	item_select.addItem("RawMeat")
	item_select.connect("itemSelected",self,"selectItem")
	item_select.connect("ammChanged",self,"changeAmm")
	flame.value = 0
	disableStart()

func selectItem(node,item):
	selectedItem = item


func changeAmm(amm):
	if(selectedItem != "Blank"):
		rawAmm = amm
		var fuelAmm = ceil(Inventory.resources[selectedItem]["cookTime"] * amm / Inventory.resources["Wood"]["burining"]["time"])
		fuel_ammount.text = str(fuelAmm) + "x"
		fuelRequired = fuelAmm
	else:
		fuelRequired = 0
		
	if(timeLeft != 0 or fuelRequired == 0 or fuelRequired > Inventory.resources["Wood"]["ammount"]):
		disableStart()
	else:
		enableStart()
			
func enableStart():
	start_button.disabled = false
	start_button.modulate.a = 1
	
func disableStart():
	start_button.disabled = true
	start_button.modulate.a = 0.4

func run(time):
	if(timeLeft > 0):
		timeLeft -= time
		if(timeLeft <= 0):
			timeLeft = 0
		time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
		flame.value = float(timeLeft)/float(timeTotal) * 100
		if(timeLeft == 0):
			finish()

func finish():
	Inventory.add_resource(cookingItem,cookAmm)
	flame.material.set_shader_param("on",0.0)
	enableStart()

func start():
	disableStart()
	Inventory.add_resource("Wood",-fuelRequired)
	Inventory.add_resource(selectedItem,-rawAmm,true)
	timeLeft = Inventory.resources[selectedItem]["cookTime"] * rawAmm
	timeTotal = timeLeft
	time_remaining.text = Global.timeGetFullFormat(timeLeft,false,true) 
	cookAmm = rawAmm
	cookingItem = Inventory.resources[selectedItem]["cooksInto"]
	flame.value = 100
	flame.material.set_shader_param("on",1.0)
	item_select.changeMaxAmm(Inventory.resources[selectedItem]["ammount"])

func _on_Start_Button_pressed() -> void:
	start()
