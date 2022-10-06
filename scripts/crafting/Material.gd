extends Craftable

class_name Craftable_Material

onready var tName = get_node("HBoxContainer/VBoxContainer2/Name")
onready var cost = $HBoxContainer/VBoxContainer/Cost
onready var timeLb = $HBoxContainer2/Time
onready var requirement: Label = $Requirement
onready var module_meet = true

func _ready() -> void:
	var item = $HBoxContainer/VBoxContainer2/TextureRect
	craft_button = get_node("HBoxContainer2/CraftButton")
	loadTex(item)
	self.tName.text = Global.splitString(self.name)

func refresh():
	_updateCost()
	_updateTime()
	_updateReq()
	if cost_meet and tool_meet and module_meet:
		enable()
	else:
		disable()
	
func _on_CraftButton_pressed() -> void:
	if Inventory.check_cost(self.name):
		craftBtAnim(true)
		Inventory.craft_item(self.name)
		Global.Craft.refreshCurTab()

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.resources[self.name],"cost",true)

func _updateReq():
	tool_meet = true
	module_meet = true
	requirement.visible = false
	if(Inventory.resources[self.name].has("requirement")):
		var req = Inventory.resources[self.name]["requirement"]
		requirement.text = ""
		if req.has("tool"):
			if(Tools.getTier(req["tool"]["name"]) < req["tool"]["tier"]):
				tool_meet = false
				requirement.visible = true
				requirement.text += "Requires " + str(req["tool"]["name"] + "\n")
		if req.has("module"):
			if(Buildings.getTierInt(req["module"]["bname"],req["module"]["mname"]) < req["module"]["tier"]):
				module_meet = false
				requirement.visible = true
				requirement.text += "Requires " +str(req["module"]["bname"]) + " " + str(req["module"]["mname"])

func _updateTime():
	var time = Inventory.get_item_craft_time(self.name)
	timeLb.text = Global.timeGetFullFormat(time,true)
	
func disable():
	disableBT()
	
func enable():
	enableBT()
	requirement.visible = false

