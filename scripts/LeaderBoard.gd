extends Node

func addRecord(prevData,time):
	var date = Time.get_datetime_dict_from_system()
	var dateStr = str(date.year) + "-" + str(date.month) + "-" + str(date.day) + "_" + str(date.hour) + ":" + str(date.minute)  + ":" + str(date.second)
	var data
	if prevData != null and ((prevData.has("bestTime") and Difficulty.is_normal()) or (prevData.has("bestHardTime")) and not Difficulty.is_normal()):
		data = addRun(prevData,time,dateStr)
	else:
		data = createRecord(time, dateStr)
	return data

func addRun(prevData,time,date):
	var data = prevData
	if Difficulty.is_normal():
		if time > data["bestTime"]:
			data["bestTime"] = time
		data["runs"][date] = {}
		data["runs"][date]["time"] = time
	else:
		if time > data["bestHardTime"]:
			data["bestHardTime"] = time
		data["runsHard"][date] = {}
		data["runsHard"][date]["time"] = time
	return data

func createRecord(time, date):
	var data = {}
	if Difficulty.is_normal():
		data["bestTime"] = time
		data["runs"] = {}
		data["runs"][date] = {}
		data["runs"][date]["time"] = time
	else:
		data["bestHardTime"] = time
		data["runsHard"] = {}
		data["runsHard"][date] = {}
		data["runsHard"][date]["time"] = time
	return data
