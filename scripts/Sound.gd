extends Node
onready var sound_container: Node = $SoundList

class_name Sound

export(Array,AudioStream) var soundList

onready var busQueue = {
	"Master":{
		"current" : null,
		"currentStream": null,
		"next": null,
		"waiting": null
	},
	"SFX":{
		"current" : null,
		"currentStream": null,
		"next": null,
		"waiting": null
	},
	"Music":{
		"current" : null,
		"currentStream": null,
		"next": null,
		"waiting": null
	},
	"Weather":{
		"current" : null,
		"currentStream": null,
		"next": null,
		"waiting": null
	}
}
enum {
	WEATHER_SUNNY = 0,
	WEATHER_CALM = 1,
	WEATHER_CLOUDY = 2,
	WEATHER_RAIN = 3,
	WEATHER_HEAVYRAIN = 4,
	WEATHER_STORM = 5,
	UI_DEFAULT = 6
}
func _ready() -> void:
	Global.Sound = self

func play(stream: int,bus = "Master",oneshoot = true):
	var player = AudioStreamPlayer.new()
	player.stream = soundList[stream]
	player.bus = bus
	sound_container.add_child(player)
	if oneshoot:
		player.connect("finished",player,"queue_free")
		player.play()
	else:
		if busQueue[bus]["current"] != null:
			if busQueue[bus]["next"] == null:
				busQueue[bus]["next"] = player
				fadeOut(busQueue[bus]["current"])
				fadeIn(busQueue[bus]["next"],bus)
			else:
				if busQueue[bus]["waiting"] != null:
					busQueue[bus]["waiting"].free()
				busQueue[bus]["waiting"] = player
		else:
			busQueue[bus]["current"] = player
			player.play()
	return player

func fadeOut(player, short = false):
	var delay = 0.8 if short else 2.0
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(player, "volume_db", -30.0, delay)
	tween.tween_callback(player, "stop")
	tween.tween_callback(player, "queue_free")
#	tween.tween_callback(self, "test",["out"])
	
func fadeIn(player,bus, short = false):
	var delay = 0.8 if short else 2.0
	player.volume_db = -30.0
	player.play()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(player, "volume_db", 0.0, delay)
	tween.tween_callback(self, "set_current",[player,bus])
#	tween.tween_callback(self, "test",["in"])

func set_current(player,bus):
	busQueue[bus]["current"] = player
	busQueue[bus]["current"] = player
	if busQueue[bus]["waiting"] != null:
		busQueue[bus]["next"] = busQueue[bus]["waiting"]
		busQueue[bus]["waiting"] = null
		fadeOut(busQueue[bus]["current"],true)
		fadeIn(busQueue[bus]["next"],bus,true)
	else:
		busQueue[bus]["next"] = null
#
#func test(p):
#	print(p)
