extends CanvasLayer

#onready var vx = get_viewport().size.x
#onready var cx = rect_position.x
var game = preload("res://nodes/Game.tscn")
onready var settings: Control = $Settings
onready var normal_save_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Normal/DateLabel
onready var hard_save_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Hard/DateLabel
onready var normal_bt_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Normal/StartNormal/Label
onready var hard_bt_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Hard/StartHard/Label
onready var leader_boards: Control = $LeaderBoards


func _ready() -> void:
	var normal_save_data = Save.loadData(Save.auto_save_file)
	var hard_save_data = Save.loadData(Save.auto_hard_save_file)
	populate_save_info(normal_save_label,normal_bt_label,normal_save_data)
	populate_save_info(hard_save_label,hard_bt_label,hard_save_data)

func populate_save_info(label,bt,data):
	if data != null:
		var date = data["date"]
		label.text = "Day " + str(date["day"]) +"\n" + Global.timeGetFullFormat(date["time"],false,true)
		bt.text = "Continue"
	else:
		label.text="New game"
		bt.text = "Start"

func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_Settings_pressed() -> void:
	settings.show()


func _on_StartNormal_pressed() -> void:
	Difficulty.current = Difficulty.Normal
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game)

func _on_StartHard_pressed() -> void:
	Difficulty.current = Difficulty.Hard
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game)

func _on_Credits_pressed() -> void:
	pass # Replace with function body.

func _on_Records_pressed() -> void:
	pass # Replace with function body.

func _on_LeaderBoardsButton_pressed() -> void:
	leader_boards.open()
