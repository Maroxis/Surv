extends Craftable

onready var tName = get_node("HBoxContainer/VBoxContainer2/Name")
onready var cost = get_node("HBoxContainer/VBoxContainer/Cost")
onready var button = get_node("HBoxContainer2/CraftButton")
onready var timeLb = $HBoxContainer2/Time
onready var requirement: Label = $Requirement

func _ready() -> void:
	var item = $HBoxContainer/VBoxContainer2/TextureRect
	loadTex(item)

func refresh():
	self.tName.text = self.name
	self.cost.clear()
	self.cost.add_item("Cost")
	for mat in Inventory.resources[self.name]["cost"]:
		var amm = Inventory.resources[self.name]["cost"][mat]
		self.cost.add_item(str(mat)+" "+str(amm),null,false)
	_updateTime()
	if(Inventory.resources[self.name].has("requirement")):
		var req = Inventory.resources[self.name]["requirement"]
		if(Tools.tools[req["tool"]]["currentTier"] < req["tier"]):
			disable(req["tool"])
		else:
			enable()
	
func _on_CraftButton_pressed() -> void:
	if Inventory.check_cost(self.name):
#		craftBtAnim(button,btOrgPos)
		Inventory.craft_item(self.name)

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.resources[self.name]["craftTime"],true)
	
func disable(req):
	self.modulate.a = 0.4
	button.disabled = true
	requirement.visible = true
	requirement.text = "Requires " + req

func enable():
	self.modulate.a = 1.0
	button.disabled = false
	requirement.visible = false
