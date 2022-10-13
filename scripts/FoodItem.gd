extends IndicatorItem

onready var calories: Label = $"%CaloriesAmm"
onready var water: Label = $"%WaterAmm"
onready var sick: Label = $"%SickAmm"

func init(itemName):
	item = itemName
	changeLabel(Global.splitString(itemName))
	changeTex(itemName)
	changeCal(itemName)
	
func changeCal(itemName):
	calories.text = str(Inventory.food[itemName]["calories"])
	if Inventory.food[itemName].has("water"):
		water.text = str(Inventory.food[itemName]["water"])
	else:
		water.text = "0"
	if Inventory.food[itemName].has("sick"):
		sick.text = str(Inventory.food[itemName]["sick"])
	else:
		sick.text = "0"
