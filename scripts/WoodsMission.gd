extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 40
	updateTravelTime()

func _on_Wood_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Wood",2):
		Player.pass_time(50)

	
func _on_Sticks_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Stick",3):
		Player.pass_time(40)

	
func _on_Leaves_Button_pressed() -> void:
	if Inventory.add_resource_to_bag("Leaf",5):
		Player.pass_time(20)






