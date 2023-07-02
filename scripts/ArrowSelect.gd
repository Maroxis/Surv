extends SceneLoader

class_name ArrowSelect

export var slider_amm = true
onready var scene = load("res://nodes/components/ItemSquareAmm.tscn")
onready var item_container: TabContainer = $"%ItemContainer"
onready var back__arrow: TextureButton = $"%Back Arrow"
onready var next__arrow: TextureButton = $"%Next Arrow"
onready var ammount_texture_progress: TextureProgress = $"%AmmountTextureProgress"
onready var h_slider: HSlider = $"%HSlider"


signal itemClicked
signal itemSelected
signal ammountChanged

func _ready() -> void:
	$"%Preview".free()
	$"%Slider".visible = slider_amm

func add_item(nm, amm = 0):
	var scene_instance : ItemSquareAmm = scene.instance()
	item_container.add_child(scene_instance)
	scene_instance.init(nm,true)
	scene_instance.changeAmm(amm)
	scene_instance.connect("itemClicked",self,"item_clicked")
	back__arrow.disabled = false
	next__arrow.disabled = false

func item_clicked(item):
	emit_signal("itemClicked",item)
	
func item_selected(item):
	emit_signal("itemSelected",item)

func get_selected_item():
	return item_container.get_tab_title(item_container.current_tab)

func set_amm(amm):
	item_container.get_current_tab_control().changeAmm(amm)

func toggle(on):
	item_container.get_current_tab_control().toggle(on)

func shake_selected_side():
	item_container.get_current_tab_control().shakeSubtleSide()

func shake_selected():
	item_container.get_current_tab_control().shakeSubtle()

func update_slider():
	var item = item_container.get_current_tab_control()
	if item != null:
		var mAmm = item.getAmm()
		h_slider.max_value = mAmm

func _on_Back_Arrow_pressed() -> void:
	item_container.current_tab = item_container.current_tab -1 if item_container.current_tab != 0 else item_container.get_tab_count()-1
	item_selected(get_selected_item())
	refresh()

func _on_Next_Arrow_pressed() -> void:
	item_container.current_tab = int(abs((item_container.current_tab +1) % item_container.get_tab_count()))
	item_selected(get_selected_item())
	refresh()

func _on_HSlider_value_changed(value: float) -> void:
	emit_signal("ammountChanged",value)
	ammount_texture_progress.value = value
	$"%LabelAmmount".text = str(value)

func _on_HSlider_changed() -> void:
	print(h_slider.max_value)
	$"%AmmountTextureProgress".max_value = h_slider.max_value
	$"%AmmountTextureProgress".value = h_slider.max_value
	$"%LabelAmmount".text = str(h_slider.max_value)

func return_children():
	return item_container.get_children()

func refresh():
	update_slider()
