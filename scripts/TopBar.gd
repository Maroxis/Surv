extends Control

onready var settings_spacer: Control = $"%SettingsSpacer"
onready var inventory_spacer: Control = $"%InventorySpacer"
onready var inventory: Control = $HBoxContainer/Inventory


func _ready() -> void:
# warning-ignore:return_value_discarded
	inventory.connect("changeFlag",self,"changeFlag")

func changeFlag():
	settings_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inventory_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
