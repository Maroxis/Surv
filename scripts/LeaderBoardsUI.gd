extends SceneLoader

onready var normal_runs: VBoxContainer = $HBoxContainer/NormalRuns/ScrollContainer/NormalRunContainer
onready var hard_runs: VBoxContainer = $HBoxContainer/HardRuns/ScrollContainer/HardRunContainer
onready var run = load("res://nodes/components/LeaderBoardRun.tscn")

func open():
	self.rect_position.x = self.rect_size.x
	show()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "rect_position:x", 0.0, 0.8)
	get_leaderboards_data()

func close():
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "rect_position:x", self.rect_size.x, 0.8)
	tween.tween_callback(self, "hide")

func get_leaderboards_data():
	clearList(normal_runs)
	clearList(hard_runs)
	var data = Save.loadRecord()
	if data != null:
		for n in range(0, data.size()):
			if data[n]["difficulty"] == Difficulty.Normal:
				var r = addScene(run,normal_runs)
				r.changeTime(data[n]["time"])
			elif data[n]["difficulty"] == Difficulty.Hard:
				var r = addScene(run,hard_runs)
				r.changeTime(data[n]["time"])

func _on_Return_Button_pressed() -> void:
	close()
