extends Control

onready var homeNode = get_node("../../Missions/Home")

func close(showHome = true):
	if(showHome):
		homeNode.show()
	self.hide()
