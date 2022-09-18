extends Node


enum type {Sunny = 0, Calm = 1, Cloudy = 2, Rain = 3, HeavyRain = 4, Storm = 5}
onready var current = type.Calm

onready var rain: Control = $Background/Rain
onready var background: TextureRect = $Background
onready var clouds: ColorRect = $Background/Clouds
onready var rng = RandomNumberGenerator.new()

onready var weatherChangeRate = 0.002 #permin
onready var progress = 0
onready var changeHelper = 1
onready var calmSustain = 1

onready var rainToxic = 0.1 # sick per unit
onready var currentSound = null
onready var light_rain_sound: AudioStreamPlayer = $Sound/LightRain
onready var heavy_rain_sound: AudioStreamPlayer = $Sound/HeavyRain
onready var calm_sound: AudioStreamPlayer = $Sound/Calm

signal weatherChanged

func _ready() -> void:
	Global.Weather = self
	changeWeatherSound()
	
func getRainInt():
	return max(current - 2,0)

func simWeather(time):
	if(current == type.Calm and rng.randi_range(0, calmSustain) == 0):
		return
	var r = rng.randi_range(0, type.size()-1)
	r -= current
	progress += float(r) * weatherChangeRate * time * changeHelper
	if progress > 1:
		setWeather(current+1)
		progress = max(fmod(progress-2,10),0)
		changeHelper = 1
	elif progress < -1:
		setWeather(current-1)
		progress = min(fmod(progress+2,10),0)
		changeHelper = 1
	else:
		changeHelper += weatherChangeRate * time


func setWeather(wthr):
	current = clamp(wthr,0,type.size()-1)
			
	deactivateSunny()
	activeClouds()
	deactiveClouds()
	deactiveRain()
	deactiveLightning()
	match current:
		type.Sunny:
			activateSunny()
		type.Calm:
			pass
		type.Cloudy:
			activeClouds()
		type.Rain:
			activeClouds()
			activeRain()
		type.HeavyRain:
			activeClouds()
			activeRain()
		type.Storm:
			activeClouds()
			activeRain()
			activeLightning()
	
	changeWeatherSound()
	emit_signal("weatherChanged")

func activeRain():
	rain.changeDensity(current)
	rain.show()

func changeWeatherSound():
	var prevSound = currentSound
	var max_db
	match current:
		type.Sunny:
			currentSound = calm_sound
			max_db = 0.0
		type.Calm:
			currentSound = calm_sound
			max_db = 0.0
		type.Cloudy:
			currentSound = calm_sound
			max_db = 0.0
		type.Rain:
			currentSound = light_rain_sound
			max_db = -10.0
		type.HeavyRain:
			currentSound = heavy_rain_sound
			max_db = -10.0
		type.Storm:
			currentSound = heavy_rain_sound
			max_db = -10.0
	if(prevSound == currentSound):
		return
	if(prevSound):
		var tween = create_tween()
		tween.tween_property(prevSound, "volume_db", -40.0, 2.4)
		tween.tween_callback(prevSound, "stop")
	if(currentSound):
		currentSound.play()
		var tween = create_tween()
		tween.tween_property(currentSound, "volume_db", max_db, 1.6)

func deactiveRain():
	rain.changeDensity(current)
	rain.hide()
	
func activeClouds():
	clouds.material.set_shader_param("cloudStrength", 0.20+0.28*current)
	clouds.material.set_shader_param("light", clamp(1.4-0.28*current,0.2,1.0))
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

func setTime(time):
	time = time / 60
	if(time >= 22 or time <= 4):
		background.material.set_shader_param("r",0.4)
		background.material.set_shader_param("g",0.4)
		background.material.set_shader_param("b",1.0)
	elif(time >= 20):
		time -= 19
		background.material.set_shader_param("r",1.0-0.3*time)
		background.material.set_shader_param("g",0.6-0.1*time)
		background.material.set_shader_param("b",0.4+0.3*time)
	elif(time <= 6):
		time -=4
		background.material.set_shader_param("r",0.4+0.3*time)
		background.material.set_shader_param("g",0.4+0.1*time)
		background.material.set_shader_param("b",1.0-0.3*time)
	elif(time >= 18):
		time -= 17
		background.material.set_shader_param("r",1.0)
		background.material.set_shader_param("g",1.0-0.2*time)
		background.material.set_shader_param("b",1.0-0.3*time)
	elif(time <= 8):
		time -= 6
		background.material.set_shader_param("r",1.0)
		background.material.set_shader_param("g",0.6+0.2*time)
		background.material.set_shader_param("b",0.4+0.3*time)
	else:
		background.material.set_shader_param("r",1.0)
		background.material.set_shader_param("g",1.0)
		background.material.set_shader_param("b",1.0)
