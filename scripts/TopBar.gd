extends Control

#onready var inventory_spacer: Control = $"%InventorySpacer"
#onready var inventory: Control = $HBoxContainer/Inventory
onready var left_container: HBoxContainer = $Left
onready var inventory: Control = $Inventory

func _ready() -> void:
	Global.TopBar = self
	inventory.marg_left = left_container.rect_size.x
	return
# warning-ignore:return_value_discarded
#	inventory.connect("changeFlag",self,"changeFlag")

#func changeFlag(expand = true):
#	return
#	if expand:
#		settings_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#		inventory_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#	else:
#		settings_spacer.size_flags_horizontal = Control.SIZE_FILL
#		inventory_spacer.size_flags_horizontal = Control.SIZE_FILL
