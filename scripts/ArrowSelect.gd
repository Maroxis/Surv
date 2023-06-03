extends Control

onready var scene = load("res://nodes/components/ItemSquareAmm.tscn")
onready var item_container: TabContainer = $ItemContainer

signal itemClicked
signal itemSelected

func add_item(nm):
	var scene_instance = scene.instance()
	item_container.add_child(scene_instance)
	scene_instance.init(nm,true)
	scene_instance.connect("itemClicked",self,"item_clicked")

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


func _on_Back_Arrow_pressed() -> void:
	item_container.current_tab = item_container.current_tab -1 if item_container.current_tab != 0 else item_container.get_tab_count()-1
	item_selected(get_selected_item())

func _on_Next_Arrow_pressed() -> void:
	item_container.current_tab = int(abs((item_container.current_tab +1) % item_container.get_tab_count()))
	item_selected(get_selected_item())
