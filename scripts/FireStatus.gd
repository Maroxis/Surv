extends Control

onready var furnace: TextureProgress = $VBoxContainer/Furnace
onready var campfire: TextureProgress = $VBoxContainer/Campfire

func _ready() -> void:
	Global.Smelt.connect("furnaceProgress",self,"furnaceProgress")
	Global.Cook.connect("cookProgress",self,"cookProgress")
	
func furnaceProgress(val):
	furnace.value = val
func cookProgress(val):
	campfire.value = val
