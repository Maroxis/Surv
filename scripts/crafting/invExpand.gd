extends Craftable

onready var benefitNr = $"%Benefit"
onready var cost = $"%Cost"
onready var timeLb = $"%Time"
onready var expAmm = Inventory.upgrades[self.name]["size"]
onready var nameLb = $"%Name"

func _ready() -> void:
	var item = $HBoxContainer/VBoxContainer2/TextureRect
	craft_button = $HBoxContainer2/CraftButton
	nameLb.text = self.name
	benefitNr.text = "+" + str(expAmm)
	loadTex(item)

func refresh():
	_updateCost()
	_updateTime()

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.upgrades[name],"cost",true)

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.upgrades[self.name]["craftTime"],true)

func _on_CraftButton_pressed() -> void:
	if(Inventory.expand_bag(self.name)):
		craft_button.disabled = true
		fade()
