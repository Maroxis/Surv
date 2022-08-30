extends Control

onready var build: Control = $Build
onready var status: Control = $Status
onready var cook: Control = $Cook
onready var craft: Control = $Craft


func _ready() -> void:
	Global.BaseAct = self
