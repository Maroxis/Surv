extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 160
	updateTravelTime()
	
	gatherTime = {
	"Rocks": 30,
	"CopperOre": 50
	}

func updateGatherTime():
	var ctier = Tools.tools["Pickaxe"]["currentTier"]
	var bonus = Tools.tools["Pickaxe"]["tier"+str(ctier)]["benefits"]["actionMult"]
	get_node("HBox/Rocks/VBox/Time").text = Global.timeGetFullFormat(floor(gatherTime["Rocks"]/bonus))
	get_node("HBox/CopperOre/VBox/Time").text = Global.timeGetFullFormat(floor(gatherTime["CopperOre"]/bonus))

func _on_Rocks_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Rock",10):
		var ctier = Tools.tools["Pickaxe"]["currentTier"]
		var bonus = Tools.tools["Pickaxe"]["tier"+str(ctier)]["benefits"]["actionMult"]
		Player.pass_time(floor(gatherTime["Rocks"]/bonus))

func _on_CopperOre_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("CopperOre",3):
		var ctier = Tools.tools["Pickaxe"]["currentTier"]
		var bonus = Tools.tools["Pickaxe"]["tier"+str(ctier)]["benefits"]["actionMult"]
		Player.pass_time(floor(gatherTime["CopperOre"]/bonus))
