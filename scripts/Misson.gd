extends Control

onready var buttonsNode = get_node("../../Buttons")

func close():
	buttonsNode.show()
	self.hide()
