extends Node


enum type {Sunny,Calm,Cloudy,Rain,HeavyRain,Storm}
var current = type.Calm
onready var rain: Control = $Rain
onready var background: TextureRect = $Background

func _ready() -> void:
	Global.Weather = self

func setWeather(wthr):
	current = wthr
	if(current >= type.Rain):
		activeRain()
	else:
		deactiveRain()
	if(current >= type.Cloudy):
		activeClouds()
	else:
		deactiveClouds()
	if(current == type.Storm):
		activeLightning()
	else:
		deactiveLightning()
	print(type.keys()[current])

func activeRain():
	rain.changeDensity(current)
	rain.show()
func deactiveRain():
	rain.changeDensity(current)
	rain.hide()
	
func activeClouds():
	background.material.set_shader_param("cloudStrength", 0.1+0.1*current)
	background.material.set_shader_param("darken",1.0-0.03*current*current)
func deactiveClouds():
	background.material.set_shader_param("cloudStrength", 0.0)
	background.material.set_shader_param("darken",1.0)

func activeLightning():
	background.material.set_shader_param("lightning",1.0)
func deactiveLightning():
	background.material.set_shader_param("lightning",0.0)

