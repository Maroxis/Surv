extends Node

func res_added(res,amm):
	if amm < 0:
		if "Carcass" in res:
			ServiceManager.inc_achivement("CgkIzazBqs8DEAIQBw",-amm)# Butcher
	elif amm > 0:
		match res:
			"Wood":
				ServiceManager.inc_achivement("CgkIzazBqs8DEAIQCA",amm) # Lumberjack
			"Thread":
				ServiceManager.inc_achivement("CgkIzazBqs8DEAIQBQ",amm) # Tailor
			"CopperIngot":
				ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQAg") # Copper Age
			"BronzeIngot":
				ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQAw") # Bronze Age
			"IronIngot":
				ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQBA") # Iron Age
		if "Ore" in res:
			ServiceManager.inc_achivement("CgkIzazBqs8DEAIQBg",amm) # Miner

func med_added(_med,amm):
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQCQ",amm) # Herbalist

func module_built(building,module):
	match building:
		"House":
			if Buildings.getTierInt("House","Bed") > 0 and Buildings.getTierInt("House","Wall") > 0 and Buildings.getTierInt("House","Roof") > 0:
				ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQCg") # Home sweet home
		"Collector":
			if Buildings.isMaxTier(building):
				ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQDg") # Well hydrated
		"Workbench":
			if Buildings.isMaxTier(building):
				ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQDQ") # Workshop
	calc_defence()

func day_passed(_days):
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQEg",1) # Expert Survivor
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQEQ",1) # Survivor
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQEA",1) # Scout
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQDw",1) # Getting hang of it

func calc_defence():
	var def = Buildings.calcDefence()
	var a1 = ServiceManager.get_achivement("CgkIzazBqs8DEAIQDA") # Welcome to my castle
	var a2 = ServiceManager.get_achivement("CgkIzazBqs8DEAIQCw") # Well defended
	if a1["state"] != 0 and a1["current_steps"] < def:
		ServiceManager.inc_achivement("CgkIzazBqs8DEAIQDA",def - a1["current_steps"])
	if a2["state"] != 0 and a2["current_steps"] < def:
		ServiceManager.inc_achivement("CgkIzazBqs8DEAIQCw",def - a2["current_steps"])

