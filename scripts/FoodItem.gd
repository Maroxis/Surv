extends IndicatorItem

onready var calories: Label = $VBoxContainer/Calories

func init(itemName):
	item = itemName
	changeLabel(Global.splitString(itemName))
	changeTex(itemName)
	changeCal(itemName)
	
func changeCal(itemName):
	calories.text = str(Inventory.food[itemName]["calories"]) + " cal"
