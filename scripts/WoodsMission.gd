extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 40
	updateTravelTime()
	
	gatherTime = {
		"Wood": 50,
		"Stick": 40,
		"Leaf": 20,
		"Rock": 40
	}
	gatherTimeWBonus = gatherTime.duplicate()

func updateGatherTime():
	var bonus
	bonus = getToolBonus("Axe")
	gatherTimeWBonus["Wood"] = floor(gatherTime["Wood"]/bonus)
	gatherTimeWBonus["Sticks"] = floor(gatherTime["Stick"]/bonus)

	bonus = getToolBonus("Knife")
	gatherTimeWBonus["Leaves"] = floor(gatherTime["Leaf"]/bonus)
	
	get_node("HBox/Wood/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Wood"])
	get_node("HBox/Sticks/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Stick"])
	get_node("HBox/Leaves/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Leaf"])

func _on_Wood_Button_pressed() -> void:
	addRes("Wood",2)

func _on_Sticks_Button_pressed() -> void:
	addRes("Stick",3)

func _on_Leaves_Button_pressed() -> void:
	addRes("Leaf",5)

func _on_Rocks_Button_pressed() -> void:
	addRes("Rock",2)

func active_wood():
	var bt = get_node("HBox/Wood/VBox/Button")
	bt.modulate = Color(1,1,1,1)
	bt.get_node("Button").disabled = false
	get_node("HBox/Wood/VBox/ToolReq").visible = false
	
func deactive_wood():
	var bt = get_node("HBox/Wood/VBox/Button")
	bt.modulate = Color(1,1,1,0.4)
	bt.get_node("Button").disabled = true
	get_node("HBox/Wood/VBox/ToolReq").visible = true
