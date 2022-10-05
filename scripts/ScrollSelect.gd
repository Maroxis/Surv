extends Control

class_name ScrollSelect

onready var item_scene = load("res://nodes/components/ItemSquare.tscn")
onready var scroll_container: ScrollContainer = $"%ScrollContainer"
onready var item_container: VBoxContainer = $"%ItemContainer"
onready var tween: Tween = $Tween
onready var label_ammount: Label = $"%LabelAmmount"
onready var ammount_texture_progress: TextureProgress = $"%AmmountTextureProgress"
onready var v_slider: VSlider = $"%VSlider"
onready var ammount_slider: Control = $"%AmmountSlider"
onready var v_box_container: HBoxContainer = $VBoxContainer

#export var it = 5
export var slider = false
export var selfControlSlider = true
var max_skew = 0.5
var item_height
var selected_item = 1
var scrolling = false

signal itemSelected
signal ammChanged

func _ready() -> void:
#	for i in it:
#		add_item("Wood")
	return

func _process(_delta: float) -> void:
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
	selectItem(item_name)
	ammount_slider.visible = slider
#	if(!slider):
#		self.rect_min_size.x -= ammount_slider.rect_size.x + v_box_container.get("custom_constants/separation")
	
func toggleSlider(on):
	slider = on
	ammount_slider.visible = on

func selectItem(item_name):
	emit_signal("itemSelected", item_name)
	if selfControlSlider:
		refreshAmmBar(item_name)

func refreshAmmBar(item_name):
	if Inventory.resources.has(item_name):
		changeMaxAmm(Inventory.get_res_amm(item_name))
	else:
		changeMaxAmm(Inventory.get_food_amm(item_name))
	changeAmm(0)

func first_skew():
	var items = item_container.get_children()
	for i in range(1,min(3,items.size())):
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
# warning-ignore:return_value_discarded
	tween.interpolate_property(scroll_container, "scroll_vertical",scroll_container.scroll_vertical, height, 0.3,Tween.TRANS_SINE,Tween.EASE_OUT)
# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "scrolling",true, false, 0.3)
# warning-ignore:return_value_discarded
	tween.start()
	var index = int(height/100+1)
	selected_item = index
	var item_name = item_container.get_children()[selected_item].item_name
	selectItem(item_name)

func _on_ScrollContainer_scroll_started() -> void:
	scrolling = true


func _on_HSlider_value_changed(amm) -> void:
	changeAmm(amm)

func changeAmm(amm):
	label_ammount.text = str(amm)
	ammount_texture_progress.value = amm
	emit_signal("ammChanged", amm)

func changeMaxAmm(mAmm):
	mAmm = int(mAmm)
	v_slider.max_value = mAmm
	ammount_texture_progress.max_value = mAmm
