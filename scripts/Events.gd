extends Node

onready var plannedEvent = {}
onready var randomEvent = {}

onready var eventDates = [3,5,7,9,12,15]
onready var eventIndex = 0
func check_date(day):
	if(eventDates[eventIndex] >= day):
		eventIndex += 1
		print("test Event "+eventIndex)
