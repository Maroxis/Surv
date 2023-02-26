extends Control

onready var tab_container: VBoxContainer = $Pages/TabContainer
onready var tab_content_container: TabContainer = $TabContentContainer
var tabs
func _ready() -> void:
	Global.GuideBook = self
	tabs = tab_container.get_children()
	tabs[0].select()
	for id in tabs.size():
		tabs[id].tab = id
		tabs[id].connect("tabClicked",self,"tabClicked")

func toggle():
	self.visible = !self.visible

func tabClicked(tab):
	tab_content_container.current_tab = tab
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
	for tb in tabs:
		tb.deselect()
	tabs[tab].select()
