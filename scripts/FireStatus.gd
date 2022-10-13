extends Control

onready var furnace: TextureProgress = $VBoxContainer/Furnace
onready var campfire: TextureProgress = $VBoxContainer/Campfire
onready var drying: TextureProgress = $VBoxContainer/Drying

func _ready() -> void:
	Global.Smelt.connect("furnaceProgress",self,"furnaceProgress")
	Global.Cook.connect("cookProgress",self,"cookProgress")
	Global.Drying.connect("dryProgress",self,"dryProgress")
	
func furnaceProgress(val):
	furnace.value = val
func cookProgress(val):
	campfire.value = val
func dryProgress(val):
	drying.value = val
