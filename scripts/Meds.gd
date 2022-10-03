extends Craftable_Material

func _ready() -> void:
	pass

func _updateCost():
	clearList(cost)
	populateList(cost,Inventory.meds[self.name],"cost",true)

func _updateReq():
	tool_meet = true
	module_meet = true
	requirement.visible = false
	if(Inventory.meds[self.name].has("requirement")):
		var req = Inventory.meds[self.name]["requirement"]
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
	timeLb.text = Global.timeGetFullFormat(Inventory.meds[self.name]["craftTime"],true)

func _on_CraftButton_pressed() -> void:
	if Inventory.check_cost(self.name, 1, Inventory.meds):
		Inventory.craft_meds(self.name)
		Global.Craft.refreshCurTab()
