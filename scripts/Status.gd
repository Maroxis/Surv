extends "res://scripts/BaseActivity.gd"

onready var list = get_node("ScrollContainer/ItemList")

func refresh():
	list.clear()
	for structure in Buildings.Structure:
		var ctier = Buildings.Structure[structure]["currentTier"]
		for bene in Buildings.Structure[structure]["tier"+str(ctier)]["benefits"]:
				var cbamm = Buildings.Structure[structure]["tier"+str(ctier)]["benefits"][bene]
				list.add_item(str(bene),null,false)
				list.add_item(str(cbamm),null,false)
				list.set_item_custom_fg_color(list.get_item_count()-1,Color(0, 1, 0, 1))
