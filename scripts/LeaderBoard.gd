extends Node

class_name Leader_Board

func addRecord(prevData,time):
	var date = Time.get_datetime_dict_from_system()
	var dateStr = str(date.year) + "-" + str(date.month) + "-" + str(date.day) + "_" + str(date.hour) + ":" + str(date.minute)  + ":" + str(date.second)
	if prevData == null or typeof(prevData) != TYPE_ARRAY:
		prevData = []
	return addRun(prevData,time,dateStr)

func addRun(prevData:Array,time,date):
	var data:Array = prevData
	var record = {}
	record["date"] = date
	record["time"] = time
	record["difficulty"] = Difficulty.current
	data.push_back(record)
	data.sort_custom(self,"sort_time")
	return data

static func sort_time(a,b):
	if a["difficulty"] != b["difficulty"]:
		return a["difficulty"] > b["difficulty"]
	return a["time"] > b["time"]

#
#func createRecord(time, date):
#	print("createNew")
#	var data = {}
#	if Difficulty.is_normal():
#		data["bestTime"] = time
#		data["runs"] = {}
#		data["runs"][date] = {}
#		data["runs"][date]["time"] = time
#	else:
#		data["bestHardTime"] = time
#		data["runsHard"] = {}
#		data["runsHard"][date] = {}
#		data["runsHard"][date]["time"] = time
#	return data

func getBestTime(data):
	if data == null or typeof(data) != TYPE_ARRAY:
		return null
	for n in range(0,data.size()):
		if data[n]["difficulty"] == Difficulty.current:
			return data[n]["time"]
	return null
