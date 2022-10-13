extends IndicatorItem

onready var calories: Label = $"%CaloriesAmm"
onready var water: Label = $"%WaterAmm"
onready var sick: Label = $"%SickAmm"
onready var spoil_progress: TextureProgress = $"%SpoilProgress"
onready var spoil_label: Label = $SpoilProgress/SpoilLabel
onready var amm_label: Label = $Ammount/AmmLabel

func init(itemName):
	item = itemName
	changeLabel(Global.splitString(itemName))
	changeTex(itemName)
	changeInfo(itemName)
	
func changeInfo(itemName):
	calories.text = str(Inventory.food[itemName]["calories"])
	if Inventory.food[itemName].has("water"):
		water.text = str(Inventory.food[itemName]["water"])
	else:
		water.text = "0"
	if Inventory.food[itemName].has("sick"):
		sick.text = str(Inventory.food[itemName]["sick"])
	else:
		sick.text = "0"
	if Inventory.foodData[itemName]["spoil"].size() > 0:
		var t = max(Inventory.foodData[itemName]["spoil"][0]["time"],0)
		spoil_progress.value = t
		var d = floor(t/1440)
		if d > 0:
			spoil_label.text = str(min(d,9))
		else:
			spoil_label.text = ""
	amm_label.text = str(Inventory.get_food_amm(itemName))
		
