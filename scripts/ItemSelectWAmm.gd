extends Control

onready var item_select: Control = $VBoxContainer/ItemSelect
onready var h_slider: HSlider = $VBoxContainer/AmmountSlider/HSlider
onready var texture_progress: TextureProgress = $VBoxContainer/AmmountSlider/TextureProgress

signal itemSelected
signal ammChanged

func _ready() -> void:
	item_select.connect("itemSelected",self,"selectItem")
	changeMaxAmm(0)

func selectItem(node,item):
	emit_signal("itemSelected", self.name, item)
	if(item != "Blank"):
		changeMaxAmm(Inventory.resources[item]["ammount"])
	else:
		changeMaxAmm(0)

func addItem(name):
	item_select.addItem(name)
	
func changeAmm(amm):
	item_select.required_label.text = str(amm) + "x"
	texture_progress.value = amm
	emit_signal("ammChanged", amm)
	
func changeMaxAmm(mAmm):
	mAmm = int(mAmm)
	h_slider.max_value = mAmm
	texture_progress.max_value = mAmm

func _on_HSlider_value_changed(value: float) -> void:
	changeAmm(value)
