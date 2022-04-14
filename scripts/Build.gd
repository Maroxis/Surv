extends "res://scripts/BaseActivity.gd"

func refresh():
	var buildings = get_node("ScrollContainer/HBox").get_children()
	for building in buildings:
		if(building.name != "Margin"):
			building.refresh()

func _on_Close_Button_pressed() -> void:
	close()
