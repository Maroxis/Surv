extends Control

onready var scroll_container: ScrollContainer = $VBoxContainer/ScrollContainer
onready var item_container: VBoxContainer = $VBoxContainer/ScrollContainer/ItemContainer
onready var required_label: Label = $VBoxContainer/Required
onready var nameLabel: Label = $VBoxContainer/Name

onready var tween: Tween = $Tween
onready var scene = load("res://nodes/ItemSelectItem.tscn")
onready var selectedItem = "Blank"

signal itemSelected

func addItem(name):
	var scene_instance = scene.instance()
	item_container.add_child(scene_instance)
	scene_instance.set_name(name)
	scene_instance.changeText(name)

func _on_ScrollContainer_scroll_ended() -> void:
	if(item_container.get_child_count() < 2):
		return
	var items = item_container.get_children()
	var index = floor(scroll_container.scroll_vertical/items[1].rect_position.y + 0.5)
	tween.interpolate_property(scroll_container, "scroll_vertical",scroll_container.scroll_vertical, int(items[index].rect_position.y*0.9), 0.3,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
	selectedItem = items[index].name
	nameLabel.text = selectedItem
	if(selectedItem == "Blank"):
		nameLabel.modulate.a = 0
	else:
		nameLabel.modulate.a = 1
	emit_signal("itemSelected", self.name, selectedItem)
#func _on_ScrollContainer_scroll_started() -> void:
#	tween.stop(scroll_container)
