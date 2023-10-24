extends Control

onready var tab_container: VBoxContainer = $Pages/TabContainer
onready var tab_content_container: TabContainer = $TabContentContainer
onready var scroll_container: ScrollContainer = $TabContentContainer/Travel/ScrollContainer
onready var bg: TextureRect = $BG
onready var category_grid_container: GridContainer = $TabContentContainer/GooglePlay/VBoxContainer/CenterContainer2/CategoryGridContainer

var tabs
func _ready() -> void:
	Global.GuideBook = self
	tabs = tab_container.get_children()
	tabs[0].select()
	for id in tabs.size():
		tabs[id].tab = id
		tabs[id].connect("tabClicked",self,"tabClicked")
	var cats = category_grid_container.get_children()
	for id in cats.size():
		cats[id].tab = id+1
		cats[id].connect("tabClicked",self,"tabClicked")
	scroll_container.get_v_scrollbar().connect("value_changed",self,"moveBG")

func toggle():
	self.visible = !self.visible

func tabClicked(tab):
	tab_content_container.current_tab = tab
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
	for tb in tabs:
		tb.deselect()
	tabs[tab].select()

func moveBG(val):
	bg.material.set_shader_param("offset", Vector2(0,-val))
