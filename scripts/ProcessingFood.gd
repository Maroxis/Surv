extends SceneLoader

class_name ProcessingFood

onready var food_label: Label = $"%FoodLabel"
onready var selectedItem = "Blank"
onready var processingItem = "Blank"
onready var rawAmm = 0
onready var processAmm = 0
onready var timeLeft : int = 0
onready var timeTotal = 0

func changeAmm(_amm):
	return
func refreshProgress():
	return

func finish():
	Inventory.add_resource(processingItem,processAmm,true)
	refreshProgress()

func selectItem(item):
	selectedItem = item
	food_label.text = Global.splitString(item)

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
				finish()
			else:
				refreshProgress()

func _on_FoodSelect_ammChanged(amm) -> void:
	changeAmm(amm)

func _on_FoodSelect_itemSelected(item) -> void:
	selectItem(item)
