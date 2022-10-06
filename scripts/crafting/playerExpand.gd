extends Craftable

onready var water: HBoxContainer = $"%Water"
onready var food: HBoxContainer = $"%Food"
onready var cost = $"%Cost"
onready var timeLb = $"%Time"
onready var nameLb = $"%Name"
onready var item_tex: TextureRect = $"%ItemTex"
onready var upg = Inventory.upgrades[self.name]
func _ready() -> void:
	if upg["size"].has("Water"):
		water.show()
		water.get_node("Label").text = "+" + str(upg["size"]["Water"])
	if upg["size"].has("Food"):
		food.show()
		food.get_node("Label").text = "+" + str(upg["size"]["Food"])
	craft_button = $HBoxContainer2/CraftButton
	nameLb.text = self.name
	loadTex(item_tex)

func refresh():
	if Inventory.get_upgrade(self.name):
		fade()
		return
	_updateCost()
	_updateTime()

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.upgrades[name],"cost",true)
	toggleBT(cost_meet)

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.upgrades[self.name]["craftTime"],true)

func _on_CraftButton_pressed() -> void:
	if Inventory.buy_upgrade(self.name):
		craft_button.disabled = true
		craftBtAnim(true)
		if upg["size"].has("Water"):
			Inventory.expand_water(self.name)
		if upg["size"].has("Food"):
			Inventory.expand_food(self.name)
		Global.Craft.refreshCurTab()
