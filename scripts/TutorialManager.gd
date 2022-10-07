extends Control

onready var current : int = 0
onready var tutorials_container: Control = $"%Tutorials"
onready var reference: TextureRect = $Reference
onready var reference_mission: TextureRect = $ReferenceMission

func _ready() -> void:
#	self.show()
	pass

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

func _on_NextButton_pressed() -> void:
	show_next()
