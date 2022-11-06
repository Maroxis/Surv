extends Control

onready var current : int = 0
onready var start_tutorials_container: Control = $"%StartTutorials"
onready var mission_tutorials_container: Control = $"%MissionTutorials"
#onready var reference: TextureRect = $Reference
#onready var reference_mission: TextureRect = $ReferenceMission


onready var tut_data = {
	"startTutorials": false,
	"missionTutorials": false
}

func _ready() -> void:
	Global.Tutorial = self
#	Global.Missions.connect("missionOpened",self,"show_tutorial",[mission_tutorials_container])
#	show_tutorial(start_tutorials_container)

func init():
	return
#	if not tut_data["startTutorials"]:
#		self.show()

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

func show_next(tutorials_container):
	var tutorials = tutorials_container.get_children()
	tutorials[current].hide()
#	reference.hide()
#	reference_mission.hide()
	if current < tutorials.size()-1:
		tutorials[current+1].show()
#		if current == 3 or current == 4:
#			reference_mission.show()
#		else:
#			reference.show()
		current += 1
	else:
		self.hide()
#		tut_data["startTutorials"] = true
#		Save.saveConfig()
#		match tutorials_container:
#			start_tutorials_container:
#				Global.Missions.connect("missionOpened",self,"show_tutorial",[mission_tutorials_container])
#			mission_tutorials_container:
#				pass

func show_tutorial(tut):
	current = 0
	self.show()
	tut.show()
	match tut:
		mission_tutorials_container:
			Global.Missions.disconnect("missionOpened",self,"show_tutorial")

func _on_StartTut_NextButton_pressed() -> void:
	show_next(start_tutorials_container)
func _on_MissionTut_NextButton_pressed() -> void:
	show_next(mission_tutorials_container)
