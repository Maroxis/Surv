extends Control

onready var current : int = 0
onready var tutorials_container: Control = $"%StartTutorials"
onready var reference: TextureRect = $Reference
onready var reference_mission: TextureRect = $ReferenceMission

onready var tut_data = {
	"startTutorials": false
}

func _ready() -> void:
	Global.Tutorial = self

func init():
	if not tut_data["startTutorials"]:
		self.show()

func pack():
	return tut_data

func unpack(data):
	for key in data:
		tut_data[key] = data[key]
	init()

func skip_all():
	for tut in tut_data:
		tut_data[tut] = true
	Save.saveConfig()

func reset():
	for tut in tut_data:
		tut_data[tut] = false
	Save.saveConfig()

func show_next():
	var tutorials = tutorials_container.get_children()
	tutorials[current].hide()
	reference.hide()
	reference_mission.hide()
	if current < tutorials.size()-1:
		tutorials[current+1].show()
		if current == 3 or current == 4:
			reference_mission.show()
		else:
			reference.show()
		current += 1
	else:
		self.hide()
		tut_data["startTutorials"] = true
		Save.saveConfig()

func _on_NextButton_pressed() -> void:
	show_next()
