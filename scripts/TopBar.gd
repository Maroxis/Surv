extends Control

#onready var inventory_spacer: Control = $"%InventorySpacer"
#onready var inventory: Control = $HBoxContainer/Inventory
onready var left_container: HBoxContainer = $Left
onready var inventory: Control = $Inventory
onready var version_label: Label = $Left/VBoxContainer/VersionLabel

func _ready() -> void:
	Global.TopBar = self
	inventory.marg_left = left_container.rect_size.x
	version_label.text = str(getVersion())
#	print(Globals.get("platform.android/version"))
#	version_label.text = Global.get("platform.android/version")
	return
# warning-ignore:return_value_discarded
#	inventory.connect("changeFlag",self,"changeFlag")
func getVersion():
	var export_config: ConfigFile = ConfigFile.new()
	var err = export_config.load("res://export_presets.cfg")
	var ver
	if err == OK:
		ver = str(export_config.get_value("preset.1.options","version/name"))
	else:
		ver = ""
	if DevMode.on:
		ver += "d"
	return ver
#func changeFlag(expand = true):
#	return
#	if expand:
#		settings_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#		inventory_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#	else:
#		settings_spacer.size_flags_horizontal = Control.SIZE_FILL
#		inventory_spacer.size_flags_horizontal = Control.SIZE_FILL
