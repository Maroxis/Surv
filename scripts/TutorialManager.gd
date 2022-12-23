extends Control

onready var current : int = 0
onready var start_tutorials_container: Control = $"%StartTutorials"
onready var mission_tutorials_container: Control = $"%MissionTutorials"
#onready var reference: TextureRect = $Reference
#onready var reference_mission: TextureRect = $ReferenceMission

func _ready() -> void:
	print(MetaData.data)
	Global.Tutorial = self
	if !MetaData.data["Tutorial"]["startTutorials"]:
		show_tutorial(start_tutorials_container)
	if !MetaData.data["Tutorial"]["missionTutorials"]:
		Global.Missions.connect("missionOpened",self,"show_tutorial",[mission_tutorials_container])

func init():
	return
#	if not tut_data["startTutorials"]:
#		self.show()

#func pack():
#	return MetaData.data["Tutorial"]
#
#func unpack(data):
#	for key in data:
#		MetaData.data["Tutorial"][key] = data[key]
#	init()

func skip_all():
	for tut in MetaData.data["Tutorial"]:
		MetaData.data["Tutorial"][tut] = true
	Save.saveMetadata()

func reset():
	for tut in MetaData.data["Tutorial"]:
		MetaData.data["Tutorial"][tut] = false
	Save.saveMetadata()

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
		match tutorials_container:
			start_tutorials_container:
				MetaData.data["Tutorial"]["startTutorials"] = true
			mission_tutorials_container:
				MetaData.data["Tutorial"]["missionTutorials"] = true
		Save.saveMetadata()

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
