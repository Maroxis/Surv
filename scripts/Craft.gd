extends "res://scripts/BaseActivity.gd"

onready var tab_container: TabContainer = $TabContainer
onready var tabAmm = tab_container.get_child_count()
#onready var tab_label: Label = $Category/BG/Control/Label
onready var TabSwitcherContainer: VBoxContainer = $TabSwitcher/VBoxContainer
onready var selected: TextureRect = $TabSwitcher/Control/Selected


func _ready() -> void:
	refresh()
	initTabs()

func initTabs():
	var tabs = TabSwitcherContainer.get_children()
	for n in tabs.size():
		tabs[n].tab = n
		tabs[n].connect("tabClicked",self,"switchTab")
	switchTab(0)

func switchTab(tab):
	tab_container.current_tab = tab
	selected.rect_position.y = TabSwitcherContainer.get_children()[tab].rect_position.y -72

func refresh():
	var tabs = tab_container.get_children()
	for tab in tabs:
		if(tab.has_node("Items")):
			var items = tab.get_node("Items").get_children()
			for item in items:
				if(item.name != "Margin" and item.name != "Margin2"):
					item.refresh()
#	tab_label.text = tab_container.get_children()[tab_container.current_tab].name


func _on_Prev_pressed() -> void:
	if(tab_container.current_tab > 0):
		tab_container.current_tab -= 1
#		tab_label.text = tab_container.get_children()[tab_container.current_tab].name

func _on_Next_pressed() -> void:
	if(tab_container.current_tab < tabAmm-1):
		tab_container.current_tab += 1
#		tab_label.text = tab_container.get_children()[tab_container.current_tab].name
