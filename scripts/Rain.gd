extends Control

onready var rain_particles: Particles2D = $"%RainParticles"

func _ready() -> void:
	var x = get_viewport().size.x*1.2
	rain_particles.position.x = x
	rain_particles.process_material.emission_box_extents = Vector3(x,100,1)

func changeDensity(dens):
	var amm = 1000
	match dens:
		Global.Weather.type.Rain:
			amm = 1000
		Global.Weather.type.HeavyRain:
			amm = 3000
		Global.Weather.type.Storm: 
			amm = 8000
	rain_particles.amount = amm
	
func show():
	self.visible = true

func hide():
	self.visible = false
