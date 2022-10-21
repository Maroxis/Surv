extends Node
onready var sound_container: Node = $SoundList

class_name Sound

export(Array,AudioStream) var soundList
enum {
	UI_DEFAULT = 0,
	STATUS_ALERT = 1
}

func _ready() -> void:
	Global.Sound = self
#	play(UI_DEFAULT)

func play(sound : int):
	var player = create_player(sound)
	player.play()
	print(sound_container)

func create_player(stream,oneshoot = true):
	var player = AudioStreamPlayer.new()
	player.stream = soundList[stream]
	player.bus = "SFX"
	sound_container.add_child(player)
	if oneshoot:
		player.connect("finished",player,"queue_free")
	return player
