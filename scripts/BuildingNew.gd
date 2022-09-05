extends Control

signal buildingSelected
onready var icon: TextureRect = $BG/VBox/Icon
onready var name_label: Label = $BG/VBox/Name

func init(nm):
	self.name = nm
	icon.texture = load("res://sprites/Icons/256x256px/"+nm.to_lower()+".png")
	icon.self_modulate = Color(0,0,0)
	name_label.text = nm

func _on_Construct_Button_pressed() -> void:
	emit_signal("buildingSelected",self.name)
