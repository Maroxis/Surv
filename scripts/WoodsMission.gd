extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 40
	updateTravelTime()
	
	gatherTime = {
	"Wood": 50,
	"Sticks": 40,
	"Leaves": 20,
	"Rocks": 40
	}

func updateGatherTime():
	var ctier = Tools.tools["Axe"]["currentTier"]
	var bonus = Tools.tools["Axe"]["tier"+str(ctier)]["benefits"]["actionMult"]
	get_node("HBox/Wood/VBox/Time").text = Global.timeGetFullFormat(floor(gatherTime["Wood"]/bonus))
	get_node("HBox/Sticks/VBox/Time").text = Global.timeGetFullFormat(floor(gatherTime["Sticks"]/bonus))
	ctier = Tools.tools["Knife"]["currentTier"]
	bonus = Tools.tools["Knife"]["tier"+str(ctier)]["benefits"]["actionMult"]
	get_node("HBox/Leaves/VBox/Time").text = Global.timeGetFullFormat(floor(gatherTime["Leaves"]/bonus))

func _on_Wood_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Wood",2):
		var ctier = Tools.tools["Axe"]["currentTier"]
		var bonus = Tools.tools["Axe"]["tier"+str(ctier)]["benefits"]["actionMult"]
		Player.pass_time(floor(gatherTime["Wood"]/bonus))

	
func _on_Sticks_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Stick",3):
		var ctier = Tools.tools["Axe"]["currentTier"]
		var bonus = Tools.tools["Axe"]["tier"+str(ctier)]["benefits"]["actionMult"]
		Player.pass_time(floor(gatherTime["Sticks"]/bonus))

	
func _on_Leaves_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Leaf",5):
		var ctier = Tools.tools["Knife"]["currentTier"]
		var bonus = Tools.tools["Knife"]["tier"+str(ctier)]["benefits"]["actionMult"]
		Player.pass_time(floor(gatherTime["Leaves"]/bonus))

func _on_Rocks_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Rock",2):
		Player.pass_time(floor(gatherTime["Rocks"]))

func active_wood():
	var bt = get_node("HBox/Wood/VBox/Button")
	bt.modulate = Color(1,1,1,1)
	bt.get_node("Button").disabled = false
	get_node("HBox/Wood/VBox/ToolReq").visible = false
