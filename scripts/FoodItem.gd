extends NodeAnimated

onready var label: Label = $VBoxContainer/Label
onready var icon: TextureRect = $VBoxContainer/Icon
var food

signal foodClicked

func _on_Button_pressed() -> void:
	emit_signal("foodClicked",food,self)

func init(itemName):
	food = itemName
	changeLabel(itemName)
	changeTex(itemName)

func changeLabel(nm):
	label.text = nm

func changeTex(tex):
	tex = tex.to_lower()
	icon.texture = load("res://sprites/Icons/resources/64p/"+tex+".png")
