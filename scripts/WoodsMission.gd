extends "res://scripts/Misson.gd"

func _on_Wood_Button_pressed() -> void:
	Player.pass_time(90)
	Inventory.add_resource("Wood")
	close()

func _on_Leaves_Button_pressed() -> void:
	Player.pass_time(30)
	Inventory.add_resource("Leaf",0,2)
	Inventory.add_resource("Stick",0,2)
	close()


func _on_Close_Button_pressed() -> void:
	close()
