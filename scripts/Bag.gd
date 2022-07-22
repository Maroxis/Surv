extends Control

onready var texProg = get_node("TextureProgress")
onready var texVal = get_node("TextureProgress/Value")

func _ready() -> void:
	Global.BagUI = self

func updateBag(emp,mx):
	texProg.value = (1 - emp / mx)*100
	texVal.text = str(emp)
