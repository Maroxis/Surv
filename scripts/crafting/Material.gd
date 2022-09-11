extends Craftable

onready var tName = get_node("HBoxContainer/VBoxContainer2/Name")
onready var cost = get_node("HBoxContainer/VBoxContainer/Cost")
onready var timeLb = $HBoxContainer2/Time
onready var requirement: Label = $Requirement


func _ready() -> void:
	var item = $HBoxContainer/VBoxContainer2/TextureRect
	craft_button = get_node("HBoxContainer2/CraftButton")
	loadTex(item)
	self.tName.text = self.name

func refresh():
	_updateCost()
	_updateTime()
	_updateReq()
	
func _on_CraftButton_pressed() -> void:
	if Inventory.check_cost(self.name):
#		craftBtAnim(craft_button,btOrgPos)
		Inventory.craft_item(self.name)
		refresh()

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.resources[self.name],"cost",true)

func _updateReq():
	if(Inventory.resources[self.name].has("requirement")):
		var req = Inventory.resources[self.name]["requirement"]
		if(Tools.tools[req["tool"]]["currentTier"] < req["tier"]):
			disable(req["tool"])
		else:
			enable()

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.resources[self.name]["craftTime"],true)
	
func disable(req):
	disableBT()
	requirement.visible = true
	requirement.text = "Requires " + req
func enable():
	enableBT()
	requirement.visible = false

