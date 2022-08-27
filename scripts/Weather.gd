extends Node


enum type {Sunny = 0, Calm = 1, Cloudy = 2, Rain = 3, HeavyRain = 4, Storm = 5}
var current = type.Calm
onready var rain: Control = $Rain
onready var background: TextureRect = $Background
onready var clouds: ColorRect = $Background/Clouds

signal weatherChanged

func _ready() -> void:
	Global.Weather = self

func getRainInt():
	return max(current - 2,0)

func setWeather(wthr):
	current = wthr
	emit_signal("weatherChanged")
	if(current == type.Sunny):
		activateSunny()
	else:
		deactivateSunny()
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
	print("Current Weather: ",type.keys()[current])

func activeRain():
	rain.changeDensity(current)
	rain.modulate.b = 1.6 - 0.2*current
	rain.modulate.g = 1.6 - 0.2*current
	rain.show()
func deactiveRain():
	rain.changeDensity(current)
	rain.hide()
	
func activeClouds():
	clouds.material.set_shader_param("cloudStrength", 0.1+0.15*current)
	clouds.material.set_shader_param("light", 1.4-0.2*current)
	background.material.set_shader_param("darken",0.8-0.02*current*current)
func deactiveClouds():
	clouds.material.set_shader_param("cloudStrength", 0.0)
	background.material.set_shader_param("darken",1.0)

func activeLightning():
	background.material.set_shader_param("lightning",1.0)
func deactiveLightning():
	background.material.set_shader_param("lightning",0.0)

func activateSunny():
	background.material.set_shader_param("sunny",1.0)
func deactivateSunny():
	background.material.set_shader_param("sunny",0.0)
