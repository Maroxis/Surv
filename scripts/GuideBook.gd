extends Control

onready var tab_container: VBoxContainer = $Pages/TabContainer
onready var tab_content_container: TabContainer = $TabContentContainer

func _ready() -> void:
	Global.GuideBook = self
	var tabs = tab_container.get_children()
	for id in tabs.size():
		tabs[id].tab = id
		tabs[id].connect("tabClicked",self,"tabClicked")

func toggle():
	self.visible = !self.visible

func tabClicked(tab):
	tab_content_container.current_tab = tab
