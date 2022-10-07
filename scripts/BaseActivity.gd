extends Control

#onready var homeNode = get_node("../../Missions/Home")

func close(_showHome = true):
#	if(showHome):
#		homeNode.show()
	self.hide()

func _on_Return_Button_pressed() -> void:
	close()

func refresh():
	return
