extends BaseActivityWTabs
onready var bg: TextureRect = $BG

func _ready() -> void:
	Global.Craft = self
	tab_container = $TabContainer
	tabAmm = tab_container.get_child_count()
	TabSwitcherContainer = $TabSwitcher/VBoxContainer
	refresh()
	connectScroll()
	initTabs()

func refresh():
	var tabs = tab_container.get_children()
	for tab in tabs:
		refreshTab(tab)

func _on_Prev_pressed() -> void:
	if(tab_container.current_tab > 0):
		tab_container.current_tab -= 1

func _on_Next_pressed() -> void:
	if(tab_container.current_tab < tabAmm-1):
		tab_container.current_tab += 1
		
func refreshCurTab():
	.refreshCurTab()
	var current = tab_container.get_current_tab_control()
	if current is ScrollContainer:
		var val = current.get_h_scrollbar().value
		moveBG(val)

func connectScroll():
	for tab in tab_container.get_children():
		if tab is ScrollContainer:
			tab.get_h_scrollbar().connect("value_changed",self,"moveBG")

func moveBG(val):
	bg.material.set_shader_param("offset", Vector2(-val,0))
