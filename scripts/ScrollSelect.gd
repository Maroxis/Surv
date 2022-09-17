extends Control


onready var item_scene = load("res://nodes/ItemSquare.tscn")
onready var scroll_container: ScrollContainer = $ScrollContainer
onready var item_container: VBoxContainer = $ScrollContainer/VBoxContainer
onready var tween: Tween = $Tween

#export var it = 5
export var max_skew = 0.5

var item_height
var selected_item = 1
var scrolling = false

signal itemSelected

func _ready() -> void:
#	for i in it:
#		add_item("Axe")
#	init()
	return

func _process(delta: float) -> void:
	if(scrolling):
		skew_items()

func init():
	var scene_instance = Control.new()
	item_container.add_child(scene_instance)
	item_height = item_container.get("custom_constants/separation")
	scene_instance.rect_min_size.y = item_container.get_children()[0].rect_size.y
	item_height += item_container.get_children()[0].rect_size.y
	first_skew()
	var item_name = item_container.get_children()[selected_item].item_name
	emit_signal("itemSelected", self.name, item_name)

func first_skew():
	var items = item_container.get_children()
	for i in range(1,3):
		if items[i].get_filename() == item_scene.get_path():
			var skew = -max_skew + i*max_skew
			items[i].setSkew(skew)

func skew_items():
	for item in item_container.get_children():
		if item.get_filename() == item_scene.get_path():
			var h = scroll_container.scroll_vertical + item_height
			var pos = item.rect_position.y-h
#			pos = clamp(pos,-item_height,item_height)
			var skew = range_lerp(pos,-item_height,item_height,-max_skew,max_skew)
			item.setSkew(skew)

func add_item(nm):
	var scene_instance = item_scene.instance()
	item_container.add_child(scene_instance)
	scene_instance.init(nm)


func _on_ScrollContainer_scroll_ended() -> void:
	var height = stepify(scroll_container.scroll_vertical,item_height)
	tween.interpolate_property(scroll_container, "scroll_vertical",scroll_container.scroll_vertical, height, 0.3,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.interpolate_property(self, "scrolling",true, false, 0.3)
	tween.start()
	var index = int(height/100+1)
	selected_item = index
	var item_name = item_container.get_children()[selected_item].item_name
	emit_signal("itemSelected", self.name, item_name)

func _on_ScrollContainer_scroll_started() -> void:
	scrolling = true
