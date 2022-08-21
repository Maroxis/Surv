extends Control

func _ready() -> void:
	Global.Missions = self

onready var woods: Control = $Woods
onready var river: Control = $River
onready var plains: Control = $Plains
onready var hills: Control = $Hills
onready var home: Control = $Home

