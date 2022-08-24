extends Craftable

onready var benefitNr = $"%Benefit"
onready var cost = $"%Cost"
onready var timeLb = $"%Time"
onready var expAmm = Inventory.upgrades[self.name]["size"]
onready var nameLb = $"%Name"
onready var button = $HBoxContainer2/CraftButton

func _ready() -> void:
	var item = $HBoxContainer/VBoxContainer2/TextureRect
	loadTex(item)

func refresh():
	benefitNr.text = "+" + str(expAmm)
	nameLb.text = self.name
	_updateCost()
	_updateTime()

func _updateCost():
	self.cost.clear()
	self.cost.add_item("Cost")
	for mat in Inventory.upgrades[name]["cost"]:
		var amm = Inventory.upgrades[name]["cost"][mat]
		self.cost.add_item(str(mat)+" "+str(amm),null,false)

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.upgrades[self.name]["craftTime"],true)

func _on_CraftButton_pressed() -> void:
	if(Inventory.expand_bag(self.name)):
		button.disabled = true
		fade()
