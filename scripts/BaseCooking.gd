extends BaseActivityWTabs

func _ready() -> void:
	Global.BaseCooking = self
	tab_container = $TabContainer
	tabAmm = tab_container.get_child_count()
	TabSwitcherContainer = $TabSwitcher/VBoxContainer
	refresh()
	initTabs()

func refresh():
	var tabs = tab_container.get_children()
	for tab in tabs:
		refreshTab(tab)
