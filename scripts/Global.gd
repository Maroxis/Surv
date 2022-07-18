extends Node

var UI
var Missions
var Date

func timeGetFullFormat(time):
	return str(floor(time/60)) + ":" + str(time%60)
