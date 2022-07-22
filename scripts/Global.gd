extends Node

var UI
var Missions
var Date
var ResourcesUI
var BagUI

func timeGetFullFormat(time,lzero = false):
	time = int(time)
	var ftime = ""
	var hour = floor(time/60)
	if lzero and hour < 10:
		ftime += "0"
	ftime += str(hour)
	ftime += ":"
	var minute = time % 60
	if(minute < 10):
		ftime += "0"
	ftime += str(minute)
	return ftime
