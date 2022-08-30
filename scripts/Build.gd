extends "res://scripts/BaseActivity.gd"

func refresh():
	var buildings = get_node("ScrollContainer/HBox").get_children()
	for building in buildings:
		if(building.name != "Margin" and building.name != "Margin2"):
			building.refresh()
