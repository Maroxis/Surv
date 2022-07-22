extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 20
	updateTravelTime()
	
	gatherTime = {
	"Water": 10,
	"Clay": 35
	}

func updateGatherTime():
	var ctier = Tools.tools["Shovel"]["currentTier"]
	var bonus = Tools.tools["Shovel"]["tier"+str(ctier)]["benefits"]["actionMult"]
	get_node("HBox/Clay/VBox/Time").text = Global.timeGetFullFormat(floor(gatherTime["Clay"]/bonus))

func _on_Water_Button_pressed() -> void:
	Player.change_water(100, true)
	Player.pass_time(floor(gatherTime["Water"]))
	close()


func _on_Close_Button_pressed() -> void:
	close()


func _on_Clay_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Clay",2):
		var ctier = Tools.tools["Shovel"]["currentTier"]
		var bonus = Tools.tools["Shovel"]["tier"+str(ctier)]["benefits"]["actionMult"]
		Player.pass_time(floor(gatherTime["Clay"]/bonus))
