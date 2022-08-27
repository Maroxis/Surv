extends Control

onready var soak_meter: ProgressBar = $SoakMeter

func _ready() -> void:
	Global.Debug = self
