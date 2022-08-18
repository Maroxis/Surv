extends Control

onready var texProg = get_node("TextureProgress")
onready var texVal = get_node("TextureProgress/Value")

func _ready() -> void:
	Global.BagUI = self

func updateBag(emp,mx):
	texProg.animateValue(float((1 - emp / mx)*100))
	if(emp != mx):
		texProg.shake()
	texVal.text = str(emp)
