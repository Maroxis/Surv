extends Control
onready var continue_bt: TextureButton = $VBoxContainer/HBoxContainer/Continue
onready var time_lived_label: Label = $VBoxContainer/TimeLivedLabel
onready var monument_built_label: Label = $VBoxContainer/MonumentBuiltLabel

func _ready() -> void:
	Global.WinScreen = self
	if Difficulty.current == Difficulty.Hard:
# warning-ignore:return_value_discarded
		Buildings.connect("moduleBuilt",self,"checkMonument")
#		continue_bt.show()
		time_lived_label.hide()
		monument_built_label.show()

func checkDay(day):
	if day == 100:
		show()

func checkMonument(module):
	if module == "Monument" and Buildings.isMaxTier("Obelisk"):
		show()

func _on_Continue_Button_pressed() -> void:
	hide()

func _on_Return_Button_pressed() -> void:
	ServiceManager.add_highscore(Global.Date.getTotalTime(),Difficulty.current)
	Global.to_title_menu()
