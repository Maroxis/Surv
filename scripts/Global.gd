extends Node

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

func timeGetFullFormat(time,lzero = false,labeled = false):
	time = int(time)
	var ftime = ""
	var hour = floor(time/60)
	if lzero and hour < 10:
		ftime += "0"
	ftime += str(hour)
	if(labeled):
		ftime +="h"
	ftime += ":"
	var minute = time % 60
	if(minute < 10):
		ftime += "0"
	ftime += str(minute)
	if(labeled):
		ftime += "m"
	return ftime
