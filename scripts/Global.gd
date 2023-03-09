extends Node
onready var TitleMenu = load("res://nodes/TitleMenu.tscn")
var UI
var Missions
var Date
var ResourcesUI
var ToolsUI
var BagUI
var EventPopup
var ChestResources
var Smelt
var Weather
var MissionButtons
var BaseAct
var Cook
var BaseCooking
var FoodEat
var Craft
var Build
var InGSettings
var GameOver
var FoodLookup
var MedsApply
var WinScreen
var Tutorial
var TopBar
var Intel
var Drying
var Sound
var GuideBook
#var TitleMenu

func refresh():
	ChestResources.refresh()
	Player.refresh_status()
	ResourcesUI.reset()
	Tools.refresh()
	Inventory.refresh()
	Craft.refresh()
	Weather.refresh()
	Date.refresh()
	Cook.refresh()
	Drying.refresh()
	Smelt.refresh()
	FoodLookup.refresh()
	Missions.refresh()
	UI.hardRefresh()
	
func timeGetFullFormat(time,lzero = false,labeled = false):
	time = int(time)
	var ftime = ""
	var hour = floor(time/60)
	if lzero and hour < 10:
		ftime += "0"
	ftime += str(hour)
	if(labeled):
		ftime += tr("hour_short")
	ftime += ":"
	var minute = time % 60
	if(minute < 10):
		ftime += "0"
	ftime += str(minute)
	if(labeled):
		ftime += tr("min_short")
	return ftime

func splitString(string):
	var result : String = ""
	var r = RegEx.new()
	r.compile("([A-Z])+([a-z])+")
	for m in r.search_all(string):
		result += m.get_string() + " "
	return result.trim_suffix(" ")

func tr_split(string):
	var finalText = tr(splitString(string))
	if finalText != splitString(string):
		return finalText
	else:
		finalText = ""
	for word in splitString(string).split(" "):
		finalText += tr(word) + " "
	finalText.trim_suffix(" ")
	return finalText

func toRoman(number):
	match number:
		1: return "I"
		2: return "II"
		3: return "III"
		4: return "IV"
		5: return "V"
		6: return "VI"
		_: return ""

func to_title_menu():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(TitleMenu)
