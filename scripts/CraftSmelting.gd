extends Control

onready var timeRemainingLabel: Label = $"%TimeLabel"
onready var furnaceProgress: TextureProgress = $"%Progress"
onready var fuel_item_select: Control = $"%Fuel"
onready var ore_item_select: Control = $"%Ore"
onready var ore_2_item_select: Control = $"%Ore2"
onready var error_label: Label = $"%ErrorLabel"
onready var start_button: Button = $"%StartButton"


onready var timeTotal = 0
onready var timeLeft = 0

var selected ={
	"Ore":{
		"name": "Blank",
		"amm": 0
	},
	"Ore2":{
		"name": "Blank",
		"amm": 0
	},
	"Fuel":{
		"name": "Blank",
		"amm": 0
	},
	"Recipe": "Blank"
}

var smeltingInProgress = ""

func _ready() -> void:
	Global.Smelt = self
	ore_item_select.connect("itemSelected",self,"selectItem")
	ore_2_item_select.connect("itemSelected",self,"selectItem")
	fuel_item_select.connect("itemSelected",self,"selectItem")
	addItems()
	checkRecipes()
	checkFuel()
	checkErrors()

func unlockItem(nm, ore):
	if(ore):
		if(ore == "CopperOre" or ore == "IronOre"):
			ore_item_select.addItem(nm)
		elif(ore == "TinOre"):
			ore_2_item_select.addItem(nm)
	else:
		fuel_item_select.addItem(nm)

func addItems():
	fuel_item_select.addItem("Wood")
	fuel_item_select.addItem("Coal")
	ore_item_select.addItem("CopperOre")
	ore_item_select.addItem("IronOre")
	ore_2_item_select.addItem("TinOre")

func selectItem(node,item):
	selected[node]["name"] = item
	checkRecipes()
	checkFuel()
	checkErrors()

func checkRecipes():
	if(timeLeft > 0):
		showError("Smelting in \nprogress")
		return
	resetRecipe()
	var amm1 = 0
	var amm2 = 0
	if(selected["Ore"]["name"] == "CopperOre"):
		if(selected["Ore2"]["name"] == "Blank"):
			amm1 = Inventory.resources["CopperIngot"]["cost"]["CopperOre"]
			selected["Recipe"] = "CopperIngot"
			
		elif(selected["Ore2"]["name"] == "TinOre"):
			amm1 = Inventory.resources["BronzeIngot"]["cost"]["CopperOre"]
			amm2 = Inventory.resources["BronzeIngot"]["cost"]["TinOre"]
			selected["Recipe"] = "BronzeIngot"

	elif(selected["Ore"]["name"] == "IronOre"):
		if(selected["Ore2"]["name"] == "Blank"):
			amm1 = Inventory.resources["IronIngot"]["cost"]["IronOre"]
			selected["Recipe"] = "IronIngot"

	selected["Ore"]["amm"] = amm1
	selected["Ore2"]["amm"] = amm2
	ore_item_select.required_label.text = str(amm1)+"x"
	ore_2_item_select.required_label.text = str(amm2)+"x"
	
func resetRecipe():
	selected["Recipe"] = "Blank"
	selected["Ore"]["amm"] = 0
	selected["Ore2"]["amm"] = 0
	selected["Fuel"]["amm"] = 0
	ore_item_select.required_label.text = "0x"
	ore_2_item_select.required_label.text = "0x"
	fuel_item_select.required_label.text = "0x"

func checkFuel():
	var ingot = selected["Recipe"]
	var fuel = selected["Fuel"]["name"]
	if(ingot != "Blank" and fuel != "Blank"):
		var amm = int(ceil(Inventory.resources[ingot]["craftTime"]/Inventory.resources[fuel]["burining"]["time"]))
		selected["Fuel"]["amm"] = amm
		fuel_item_select.required_label.text = str(amm)+"x"

func checkErrors():
	if(selected["Recipe"] == "Blank"):
		showError("No recipe")
		return
	if(selected["Fuel"]["name"] == "Blank"):
		showError("No fuel")
		return
	if(Inventory.resources[selected["Recipe"]]["furnaceTier"] > Buildings.Structure["Furnace"]["Oven"]["currentTier"]):
		showError("Furnace tier \nto low")
		return
	if(Inventory.resources[selected["Recipe"]]["meltingTemp"] > Inventory.resources[selected["Fuel"]["name"]]["burining"]["temp"]):
		fuel_item_select.required_label.text = "---"
		showError("Fuel temp to low")
		return
	if(selected["Ore"]["amm"] > Inventory.resources[selected["Ore"]["name"]]["ammount"]):
		showError("Not enough\n"+selected["Ore"]["name"])
		return
	if(selected["Ore2"]["amm"] != 0 and selected["Ore2"]["amm"] > Inventory.resources[selected["Ore2"]["name"]]["ammount"]):
		showError("Not enough\n"+selected["Ore2"]["name"])
		return
	if(selected["Fuel"]["amm"] > Inventory.resources[selected["Fuel"]["name"]]["ammount"]):
		showError("Not enough fuel")
		return
	hideError()

func showError(err):
	error_label.text = err
	error_label.modulate.a = 1
	disableStart()

func hideError():
	error_label.modulate.a = 0
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
		timeRemainingLabel.text = Global.timeGetFullFormat(timeLeft,false,true) 
		furnaceProgress.value = float(timeLeft)/float(timeTotal) * 100
		if(timeLeft == 0):
			finish()

func finish():
	Inventory.add_resource(smeltingInProgress,1)
	furnaceProgress.material.set_shader_param("on",0.0)
	enableStart()

func start(time):
	time *= Buildings.getCurrentModule("Furnace","Bellows")["benefits"]["timeMult"]
	disableStart()
	removeRes()
	smeltingInProgress = selected["Recipe"]
	timeTotal = time
	timeLeft = time
	timeRemainingLabel.text = Global.timeGetFullFormat(time,false,true) 
	furnaceProgress.value = 100
	furnaceProgress.material.set_shader_param("on",1.0)

func removeRes():
	Inventory.add_resource(selected["Ore"]["name"],-selected["Ore"]["amm"])
	if(selected["Ore2"]["amm"] > 0):
		Inventory.add_resource(selected["Ore2"]["name"],-selected["Ore2"]["amm"])
	Inventory.add_resource(selected["Fuel"]["name"],-selected["Fuel"]["amm"])

func _on_Start_Button_pressed() -> void:
	var time = Inventory.resources[selected["Recipe"]]["craftTime"]
	start(time)


func _on_Smelting_visibility_changed() -> void:
	if(visible):
		checkRecipes()
