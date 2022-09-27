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
	if cost_meet and tool_meet:
		enable()
	else:
		disable()
	
func _on_CraftButton_pressed() -> void:
	if Inventory.check_cost(self.name):
#		craftBtAnim(craft_button,btOrgPos)
		Inventory.craft_item(self.name)
		Global.Craft.refreshCurTab()

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.resources[self.name],"cost",true)

func _updateReq():
	tool_meet = true
	if(Inventory.resources[self.name].has("requirement")):
		var req = Inventory.resources[self.name]["requirement"]
		if(Tools.getTier(req["tool"]) < req["tier"]):
			tool_meet = false
			requirement.visible = true
			requirement.text = "Requires " + str(req["tool"])

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.resources[self.name]["craftTime"],true)
	
func disable():
	disableBT()
	
func enable():
	enableBT()
	requirement.visible = false

