extends "res://scripts/Misson.gd"

onready var drinkNode = get_node("VBoxContainer/HBox2/Drink")
onready var drinkNodeAmm = drinkNode.get_node("VBox/Ammount")

func updateGatherTime():
	return

func _on_Return_Button_pressed() -> void:
	close()

func _on_Sleep_Button_pressed() -> void:
	Player.sleep()
#	close()

func _on_Build_Button_pressed() -> void:
	Global.BaseAct.build.show()
	Global.BaseAct.build.refresh()
#	close(false)

func _on_Craft_Button_pressed() -> void:
	Global.BaseAct.craft.show()
	Global.BaseAct.craft.refresh()
#	close(false)

func _on_Status_Button_pressed() -> void:
	Global.BaseAct.status.show()
	Global.BaseAct.status.refresh()
#	close(false)

func _on_Drink_Button_pressed() -> void:
	var amm
	if(Player.water + Buildings.Structure["Collector"]["waterLevel"] > Player.maxWater):
		amm = Player.maxWater - Player.water
	else:
		amm = Buildings.Structure["Collector"]["waterLevel"]
	Player.change_water(amm)
	Buildings.changeWaterLevel(-amm)
	var sick = Global.Weather.rainToxic - Buildings.getCurrentModule("Collector","Filter")["benefits"]["filter"]
	if sick > 0:
		Player.change_sick(sick*amm)

func _activateDrink():
	drinkNode.modulate = Color(1,1,1,1)
	drinkNode.get_node("VBox/Button/Button").disabled = false
	
func _deactivateDrink():
	drinkNode.modulate = Color(1,1,1,0.4)
	drinkNode.get_node("VBox/Button/Button").disabled = true


func _on_Cook_Button_pressed() -> void:
	Global.BaseAct.cook.show()
	Global.BaseAct.cook.refresh()
#	close(false)


func _on_Home_visibility_changed() -> void:
	if visible:
		if(Buildings.getTierInt("Collector","Tank") > 0):
			_activateDrink()
		else:
			_deactivateDrink()
