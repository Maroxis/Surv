extends SceneLoader

class_name BaseActivity
#onready var homeNode = get_node("../../Missions/Home")

func close():
	self.hide()

func _on_Return_Button_pressed() -> void:
	close()

func refresh():
	return
