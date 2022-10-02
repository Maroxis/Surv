extends Craftable_Material

func _ready() -> void:
	pass

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.meds[self.name],"cost",true)

func _updateReq():
	tool_meet = true
#	if(Inventory.meds[self.name].has("requirement")):
#		var req = Inventory.meds[self.name]["requirement"]
#		if(Tools.getTier(req["tool"]) < req["tier"]):
#			tool_meet = false
#			requirement.visible = true
#			requirement.text = "Requires " + str(req["tool"])

func _updateTime():
	timeLb.text = Global.timeGetFullFormat(Inventory.meds[self.name]["craftTime"],true)

func _on_CraftButton_pressed() -> void:
	print(self.name)
	return
