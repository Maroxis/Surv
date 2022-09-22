extends SceneLoader

onready var carcass_select: Control = $HBoxContainer/CarcassSelect
onready var item_scene  = load("res://nodes/components/ItemSquareAmm.tscn")
onready var output_container: VBoxContainer = $HBoxContainer/OutputContainer
onready var butcher_button: ToolButton = $HBoxContainer/VBoxContainer/ButcherButton
onready var time_label: Label = $HBoxContainer/VBoxContainer/TimeLabel

var selectedCarcass

func _ready() -> void:
	addCarcassItems()

func getCraftTime():
	return Global.timeGetFullFormat(Inventory.food[selectedCarcass]["craftTime"],false,true)

func getButcherBonus():
	return 1

func addCarcassItems():
	for res in Inventory.food:
		if Inventory.food[res].has("carcass"):
			carcass_select.add_item(res)
	carcass_select.init()

func butcher():
	if Inventory.add_resource(selectedCarcass,-1,true):
		for res in Inventory.food[selectedCarcass]["deconstruct"]:
			var amm = floor(Inventory.food[selectedCarcass]["deconstruct"][res]*getButcherBonus())
			var fd = Inventory.food.has(res)
			Inventory.add_resource(res,amm,fd)
		Player.pass_time(Inventory.food[selectedCarcass]["craftTime"])

func refreshOutput():
	clearList(output_container)
	for res in Inventory.food[selectedCarcass]["deconstruct"]:
		var scene = addScene(item_scene,output_container)
		scene.init(res,false)
		scene.changeAmm(Inventory.food[selectedCarcass]["deconstruct"][res])

func refresh():
	refreshTime()
	refreshButton()
	refreshOutput()

func refreshTime():
	time_label.text = getCraftTime()

func refreshButton():
	if(Inventory.get_food_amm(selectedCarcass) == 0):
		butcher_button.disable()
	else:
		butcher_button.enable()

func _on_CarcassSelect_itemSelected(item) -> void:
	selectedCarcass = item
	refresh()

func _on_ButcherButton_pressed() -> void:
	butcher()

func _on_Butchering_visibility_changed() -> void:
	refresh()
