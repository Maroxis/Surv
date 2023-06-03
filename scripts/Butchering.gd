extends SceneLoader

onready var carcass_select: Control = $HBoxContainer/VBoxContainer2/CarcassSelect
onready var item_scene  = load("res://nodes/components/ItemSquareAmm.tscn")
onready var output_container: VBoxContainer = $HBoxContainer/OutputContainer
onready var time_label: Label = $"%TimeLabel"

var selectedCarcass

func _ready() -> void:
	addCarcassItems()

func getCraftTime():
	var time = Inventory.food[selectedCarcass]["craftTime"]
	time /= Tools.getBonus("Knife")
	return Global.timeGetFullFormat(time,false,true)

func getButcherBonus():
	return 1

func addCarcassItems():
	for res in Inventory.food:
		if Inventory.food[res].has("carcass"):
			carcass_select.add_item(res)
			carcass_select.set_amm(Inventory.get_food_amm(res))
	selectedCarcass = carcass_select.get_selected_item()

func butcher():
	if Inventory.add_resource(selectedCarcass,-1,true):
		Global.Sound.play(Sound.UI_CHOP, "SFX")
		for res in Inventory.food[selectedCarcass]["deconstruct"]:
			var amm = floor(Inventory.food[selectedCarcass]["deconstruct"][res]*getButcherBonus())
			var fd = Inventory.food.has(res)
			Inventory.add_resource(res,amm,fd)
		Player.pass_time(Inventory.food[selectedCarcass]["craftTime"])
		carcass_select.shake_selected()
		refreshButton()
		Achivements.animal_butchered()

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
	carcass_select.set_amm(Inventory.get_food_amm(selectedCarcass))
	if(Inventory.get_food_amm(selectedCarcass) == 0):
		carcass_select.toggle(false)
	else:
		carcass_select.toggle(true)

func _on_CarcassSelect_itemSelected(item) -> void:
	selectedCarcass = item
	refresh()

func _on_Butchering_visibility_changed() -> void:
	refresh()

func _on_CarcassSelect_itemClicked(_item) -> void:
	butcher()
