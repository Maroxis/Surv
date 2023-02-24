extends Control

func _ready() -> void:
	Global.GuideBook = self

func toggle():
	self.visible = !self.visible
