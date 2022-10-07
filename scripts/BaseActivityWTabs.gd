extends "res://scripts/BaseActivity.gd"

class_name BaseActivityWTabs

onready var tab_container
onready var tabAmm
onready var TabSwitcherContainer

func initTabs():
	var tabs = TabSwitcherContainer.get_children()
	for n in tabs.size():
		tabs[n].tab = n
		tabs[n].connect("tabClicked",self,"switchTab")
	tabs[0].select()
	switchTab(0)

func switchTab(tab):
	TabSwitcherContainer.get_children()[tab_container.current_tab].deselect()
	TabSwitcherContainer.get_children()[tab].select()
	tab_container.current_tab = tab
	refreshCurTab()

func refreshCurTab():
	refreshTab(tab_container.get_current_tab_control())

func refreshTab(tab):
	if tab.has_method("refresh"):
		tab.refresh()
	elif tab.has_node("Items"):
		var items = tab.get_node("Items").get_children()
		for item in items:
			if(item.name != "Margin" and item.name != "Margin2"):
				item.refresh()
