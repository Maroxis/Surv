extends Control

onready var buttonsNode = get_node("../../Buttons")

func close(showNode = true):
	if(showNode):
		buttonsNode.show()
	self.hide()
