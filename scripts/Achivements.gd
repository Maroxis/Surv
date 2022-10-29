extends Node

func res_added(res,amm):
	if not ServiceManager.is_signed_in():
		return
#	if amm < 0:
#		if "Carcass" in res:
#			ServiceManager.inc_achivement("CgkIzazBqs8DEAIQBw",-amm)# Butcher
	if amm > 0:
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
	if not ServiceManager.is_signed_in():
		return
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQCQ",amm) # Herbalist

func animal_butchered():
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQBw",1) # Butcher

func module_built(building,_module):
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

func day_passed(days):
	if not ServiceManager.is_signed_in():
		return
	ServiceManager.set_achivement_steps("CgkIzazBqs8DEAIQEg",days) # Expert Survivor
	ServiceManager.set_achivement_steps("CgkIzazBqs8DEAIQEQ",days) # Survivor
	ServiceManager.set_achivement_steps("CgkIzazBqs8DEAIQEA",days) # Scout
	ServiceManager.set_achivement_steps("CgkIzazBqs8DEAIQDw",days) # Getting hang of it

func calc_defence():
	if not ServiceManager.is_signed_in():
		return
	var def = Buildings.calcDefence()
	ServiceManager.set_achivement_steps("CgkIzazBqs8DEAIQDA",def) # Welcome to my castle
	ServiceManager.set_achivement_steps("CgkIzazBqs8DEAIQCw", def) # Well defended

func rats_eat(amm):
	if not ServiceManager.is_signed_in():
		return
	ServiceManager.reveal_achivement("CgkIzazBqs8DEAIQEw")
	ServiceManager.inc_achivement("CgkIzazBqs8DEAIQEw",amm) # Plague

func full_sick():
	if not ServiceManager.is_signed_in():
		return
	ServiceManager.reveal_achivement("CgkIzazBqs8DEAIQFA")
	ServiceManager.unlock_achivement("CgkIzazBqs8DEAIQFA") # Gravely sick
