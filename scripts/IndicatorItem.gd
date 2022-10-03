extends NodeAnimated

class_name IndicatorItem

onready var label: Label = $VBoxContainer/Label
onready var icon: TextureRect = $VBoxContainer/Icon
var item

signal itemClicked

func _on_Button_pressed() -> void:
	emit_signal("itemClicked",item,self)

func init(itemName):
	item = itemName
	changeLabel(itemName)
	changeTex(itemName)

func changeLabel(nm):
	label.text = nm

func changeTex(tex):
	tex = tex.to_lower()
	icon.texture = load("res://sprites/Icons/64x64px/"+tex+".png")
