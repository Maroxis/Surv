extends VBoxContainer

onready var tName = get_node("HBoxContainer/VBoxContainer2/Name")
onready var cost = get_node("HBoxContainer/VBoxContainer/Cost")
onready var button = get_node("HBoxContainer2/CraftButton")
onready var timeLb = $"%Time"

func refresh():
	self.tName.text = self.name
	self.cost.clear ( )
	self.cost.add_item("Cost")
	for mat in Inventory.resources[self.name]["cost"]:
		var amm = Inventory.resources[self.name]["cost"][mat]
		self.cost.add_item(str(mat)+" "+str(amm),null,false)
	_updateTime()
	
func _on_CraftButton_pressed() -> void:
	if Inventory.check_cost(self.name):
		Inventory.craft_item(self.name)

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.resources[self.name]["craftTime"],true)
