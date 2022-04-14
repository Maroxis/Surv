extends "res://scripts/BaseActivity.gd"

func refresh():
	var buildings = get_node("ScrollContainer/HBox").get_children()
	for building in buildings:
		if building.name == "Margin":
			continue
		building.bName.text = building.name
		
		building.cost.clear ( )
		building.cost.add_item("Cost")
		building.benefits.clear ( )
		var ctier = Buildings.Structure[building.name]["currentTier"]
		for mat in Buildings.Structure[building.name]["tier"+str(ctier+1)]["cost"]:
			var amm = Buildings.Structure[building.name]["tier"+str(ctier+1)]["cost"][mat]
			building.cost.add_item(str(mat)+" "+str(amm),null,false)
		for bene in Buildings.Structure[building.name]["tier"+str(ctier+1)]["benefits"]:
			var bamm = Buildings.Structure[building.name]["tier"+str(ctier+1)]["benefits"][bene]
			var cbamm
			if(ctier == 0):
				if(building.name == "House"):
					if(bene == "sleepMult"):
						cbamm = Player.sleepMult
					else:
						cbamm = Player.sleepRegenMult
				else:
					cbamm = 0
			else:
				cbamm = Buildings.Structure[building.name]["tier"+str(ctier)]["benefits"][bene]
			building.benefits.add_item(str(bene),null,false)
			building.benefits.add_item(str(cbamm)+" -> "+str(bamm),null,false)
			building.benefits.set_item_custom_fg_color(building.benefits.get_item_count()-1,Color(0, 1, 0, 1))
		building.tier.get_node("Current").text = str(ctier)
		building.tier.get_node("Next").text = str(ctier+1)

func _on_Close_Button_pressed() -> void:
	close()


func _on_House_Button_pressed() -> void:
	pass # Replace with function body.


func _on_WaterTank_Button_pressed() -> void:
	pass # Replace with function body.


func _on_Furnace_Button_pressed() -> void:
	pass # Replace with function body.


func _on_Wall_Button_pressed() -> void:
	pass # Replace with function body.


