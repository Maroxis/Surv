extends Control

onready var homeNode = get_node("../../Missions/Home")

func close():
	homeNode.show()
	self.hide()
