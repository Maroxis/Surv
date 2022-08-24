extends "res://scripts/BaseActivity.gd"

onready var tab_container: TabContainer = $TabContainer
onready var tabAmm = tab_container.get_child_count()
onready var tab_label: Label = $Category/BG/Control/Label


func _ready() -> void:
	refresh()

func refresh():
	var tabs = tab_container.get_children()
	for tab in tabs:
		if(tab.has_node("Items")):
			var items = tab.get_node("Items").get_children()
			for item in items:
				if(item.name != "Margin" and item.name != "Margin2"):
					item.refresh()
	tab_label.text = tab_container.get_children()[tab_container.current_tab].name


func _on_Prev_pressed() -> void:
	if(tab_container.current_tab > 0):
		tab_container.current_tab -= 1
		tab_label.text = tab_container.get_children()[tab_container.current_tab].name

func _on_Next_pressed() -> void:
	if(tab_container.current_tab < tabAmm-1):
		tab_container.current_tab += 1
		tab_label.text = tab_container.get_children()[tab_container.current_tab].name
		
func _on_Return_Button_pressed() -> void:
	close()
