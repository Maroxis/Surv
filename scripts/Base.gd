extends "res://scripts/Misson.gd"

onready var buildScreen = get_node("../../BaseActivities/Build")
onready var statusScreen = get_node("../../BaseActivities/Status")
onready var craftScreen = get_node("../../BaseActivities/Craft")
onready var drinkNode = get_node("VBoxContainer/HBox2/Drink")
onready var drinkNodeAmm = drinkNode.get_node("VBox/Ammount")

func updateGatherTime():
	return

func _on_Return_Button_pressed() -> void:
	close()

func _on_Sleep_Button_pressed() -> void:
	Player.sleep()
	close()

func _on_Build_Button_pressed() -> void:
	buildScreen.show()
	buildScreen.refresh()
	close(false)

func _on_Craft_Button_pressed() -> void:
	craftScreen.show()
	craftScreen.refresh()
	close(false)

func _on_Status_Button_pressed() -> void:
	statusScreen.show()
	statusScreen.refresh()
	close(false)

func _on_Drink_Button_pressed() -> void:
	if(Player.water + Buildings.Structure["Collector"]["waterLevel"] > Player.maxWater):
		Buildings.changeWaterLevel(-(Player.maxWater - Player.water))
		Player.change_water(Player.maxWater,true)
	else:
		Player.change_water(Buildings.Structure["Collector"]["waterLevel"])
		Buildings.changeWaterLevel(0,true) 

func activateDrink():
	drinkNode.modulate = Color(1,1,1,1)
	drinkNode.get_node("VBox/Button/Button").disabled = false
