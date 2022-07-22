extends "res://scripts/BaseActivity.gd"

func _on_Return_Button_pressed() -> void:
	close()

func refresh():
	var items = get_node("TabContainer/Hand Craft/HBox").get_children()
	for item in items:
		if(item.name != "Margin" and item.name != "Margin2"):
			item.refresh()
