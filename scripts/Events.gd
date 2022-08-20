extends Node

var rng = RandomNumberGenerator.new()

onready var plannedEvent = {
	"event0":{
		"title":"Event 0",
		"desc": "event description",
		"function": "testTimed",
		"params": 2
	}
}
onready var randomEvent = {
	"event0":{
		"title":"R Event 0",
		"desc": "Random event0 description",
		"function": "test"
	},
	"event1":{
		"title":"R Event 1",
		"desc": "Random event1 description",
		"function": "test",
		"params": ["rrrr1"]
	}
}

onready var eventDates = [2,3,4,5,6,8]
onready var eventIndex = 0

func _ready() -> void:
	rng.randomize()

func check_event(day):
	if(eventDates[eventIndex] == day):
		var ev
		if(plannedEvent.size() > eventIndex):
			ev = plannedEvent["event"+str(eventIndex)]
		else:
			var r = rng.randi_range(0, randomEvent.size()-1)
			ev = randomEvent["event"+str(r)]
		
		Global.EventPopup.populate(ev["title"],ev["desc"])
		Global.EventPopup.show()
		
		if(ev.has("params")):
			call(ev["function"],ev["params"])
		else:
			call(ev["function"])
		
		eventIndex += 1

func test(a = ["error no args"]):
	for item in a:
		print(item)

func testTimed(time, eDay = null):
	if(eDay):
		if(eDay == time):
			print("testEvent finish")
	else:
		print("testEvent started")
		var endDay = Global.Date.day + time
		Global.Date.connect("newDay",self,"testTimed",[endDay])
	
