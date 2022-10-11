extends Node

func addRecord(prevData,time):
	var date = Time.get_datetime_dict_from_system()
	var dateStr = str(date.year) + "-" + str(date.month) + "-" + str(date.day) + "_" + str(date.hour) + ":" + str(date.minute)  + ":" + str(date.second)
	var data
	if prevData != null:
		data = addRun(prevData,time,dateStr)
	else:
		data = createRecord(time, dateStr)
	return data

func addRun(prevData,time,date):
	var data = prevData
	if time > data["bestTime"]:
		data["bestTime"] = time
	data["runs"][date] = {}
	data["runs"][date]["time"] = time
	return data

func createRecord(time, date):
	var data = {}
	data["bestTime"] = time
	data["runs"] = {}
	data["runs"][date] = {}
	data["runs"][date]["time"] = time
	return data
