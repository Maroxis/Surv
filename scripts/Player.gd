extends Node

#0.07 ~= 100 per day
var thirstRate = 0.14 #per minute
var hungerRate = 0.07 #per minute
var regenRate = 0.01 #per minute
var exhaustRate = 0.08 #per minute
var sickRate = 0.002 #per minute
var soakRate = 0.4 #per minute
var dryRate = 0.4 #per minute

var maxWater = 100
var maxFood = 100
var maxHealth = 100
var maxEnergy = 100

var lowWarning = 20

var water = 40.0
var food = 80.0
var health = 100.0
var energy = 100.0

var sick = 0
var soaked = 0

var medsBuff = {}

func _ready() -> void:
	reset_meds()

func pack():
	var dict = {}
	dict["maxWater"] = maxWater
	dict["maxFood"] = maxFood
	dict["maxHealth"] = maxHealth
	dict["maxEnergy"] = maxEnergy
	dict["water"] = water
	dict["food"] = food
	dict["health"] = health
	dict["energy"] = energy
	dict["sick"] = sick
	dict["soaked"] = soaked
	dict["medsBuff"] = medsBuff
	return dict

func unpack(dict):
	if dict.has("maxWater"):
		maxWater = dict["maxWater"]
	if dict.has("maxFood"):
		maxFood = dict["maxFood"]
	if dict.has("maxHealth"):
		maxHealth = dict["maxHealth"]
	if dict.has("maxEnergy"):
		maxEnergy = dict["maxEnergy"]
	if dict.has("water"):
		water = dict["water"]
	if dict.has("food"):
		food = dict["food"]
	if dict.has("health"):
		health = dict["health"]
	if dict.has("energy"):
		energy = dict["energy"]
	if dict.has("sick"):
		sick = dict["sick"]
	if dict.has("soaked"):
		soaked = dict["soaked"]
	if dict.has("medsBuff"):
		medsBuff = dict["medsBuff"]

func refresh_status():
	Global.UI.refresh()

func reset_meds():
	medsBuff = {
		"time": 0,
		"totalTime": 0,
		"sickGain": 1.0,
		"sickReduction": 1.0,
		"healthRegen": 1.0
	}

func apply_med(medName):
	var med = Inventory.meds[medName]
	for buff in med["buffs"]:
		medsBuff[buff] = med["buffs"][buff]
	medsBuff["totalTime"] = medsBuff["time"]
	Inventory.add_meds(medName,-1)
	Global.UI.refreshHealth()
	deplete_meds(0)

func soak(amm):
	var soakLimit = Difficulty.get_soak_limit()
	soaked += amm
	if(soaked > soakLimit):
		change_sick(ceil((soaked-soakLimit) / 20))
		soaked = soakLimit
	DevMode.DebugUI.soak_meter.value = soaked

func dry(time):
	if(Global.Weather.current == Global.Weather.type.Sunny):
		soaked -= dryRate*time*2
	else:
		soaked -= dryRate*time
	if(soaked < 0):
		soaked = 0
	DevMode.DebugUI.soak_meter.value = soaked

func change_water(amm, set = false):
	if(amm == 0 and not set):
		return
	if(water == 0 && amm < 0):
		change_health(amm, GameOver.reasons.Water)
	if(set):
		water = amm
	else:
		water += amm
	water = clamp(water,0,maxWater)
	_upd_water(amm)

func _upd_water(amm):
	if(water < lowWarning && amm < 0):
		Global.UI.water.shake()
	Global.UI.refreshWater()
	
func upd_max_water(mx):
	maxWater += mx
	Global.UI.refreshMaxWater()
func upd_max_food(mx):
	maxFood += mx
	Global.UI.refreshMaxFood()
	
func change_food(amm, set = false, over = false):
	if(amm == 0 and not set):
		return
	if(food == 0 && amm < 0):
		change_health(amm*2,GameOver.reasons.Food)
	if(set):
		food = amm
	else:
		food += amm
	if not over:
		food = clamp(food,0,maxFood)
	if(food < lowWarning && amm < 0):
		Global.UI.food.shake()
	Global.UI.refreshFood()
	
func change_health(amm, reason = null, set = false):
	if(amm == 0 and not set):
		return
	if(set):
		health = amm
	else:
		if amm > 0:
			amm *= medsBuff["healthRegen"] * Difficulty.get_health_regen_multiplayer()
		else:
			amm *= Difficulty.get_health_damage_multiplayer()
			amm /= medsBuff["healthRegen"]
		health += amm
	health = clamp(health,0,maxHealth)
	if(health < lowWarning && amm < 0):
		Global.UI.health.shake()
		Global.Sound.play_loop(Sound.UI_LOW_HEALTH_LOOP, "SFX_LOOP_GLOBAL")
	elif(health > lowWarning and amm > 0):
		Global.Sound.stop_loop(Sound.UI_LOW_HEALTH_LOOP)
		
	Global.UI.refreshHealth()
	if(health <= 0):
		Global.GameOver.init(reason)

func change_energy(amm, set = false):
	if(energy == 0 && amm < 0):
		change_health(amm/2, GameOver.reasons.Energy)
	if(set):
		energy = amm
	else:
		energy += amm
	energy = clamp(energy,0,maxEnergy)
	if(energy < lowWarning && amm < 0):
		Global.UI.energy.shake()
	Global.UI.refreshEnergy()

func sleep():
	var sleepTime = 360
	pass_time(sleepTime,true)
	Global.Sound.play(Sound.UI_SLEEP, "SFX")
	
func pass_time(time,sleep=false,wet = false):
	time = int(time)
	var sleepRegenMult = Buildings.getCurrentModule("House","Bed")["benefits"]["sleepRegenMult"] if sleep else 1.0
	var weatherPenalty = 1.2 if(Global.Weather.current == Global.Weather.type.Sunny) else 1.0
	var soakMult = Global.Weather.getRainInt()
	if(wet and soakMult > 0):
		soak(time*soakMult*soakRate*(1+Global.Weather.rainToxic))
	elif(soaked > 0):
		dry(time)
	if(sick > 0 and (Global.Weather.getRainInt() < 1 or not wet)):
		var fullBonus = 2 if food > 50 and water > 50 else 1
		change_sick(-(sickRate*time*sleepRegenMult*fullBonus))
	var sickPenaltyMlt = 1.0 if sick < 20 else 0.8
	if(food > 50 && water > 30 && sick < 50):
		change_health(time*regenRate*sleepRegenMult*sickPenaltyMlt, GameOver.reasons.Sick)
	elif(sick > 80):
		change_health(-(time*regenRate), GameOver.reasons.Sick)
	change_water(-(time*thirstRate*weatherPenalty/sickPenaltyMlt))
	change_food(-(time*hungerRate/sickPenaltyMlt))
	if sleep:
		change_energy(maxEnergy-sick)
	else:
		change_energy(-(time*exhaustRate*weatherPenalty))
	
	Buildings.runCollector(time)
	Inventory.spoil_food(time)
	Global.Smelt.run(time)
	Global.Cook.run(time)
	Global.Drying.run(time)
	Global.Weather.simWeather(time)
	Global.Date.changeTime(time)
	deplete_meds(time)
	if DevMode.godMode:
		DevMode.keep_status_full()
func deplete_meds(time):
	medsBuff["time"] -= time
	if medsBuff["time"] <= 0:
		reset_meds()
	Global.UI.refreshHealth()

func change_sick(amm):
	if amm > 0:
		amm *= medsBuff["sickGain"] * Difficulty.get_sick_gain_multiplayer()
	else:
		amm *= medsBuff["sickReduction"] * Difficulty.get_sick_reduction_multiplayer()
	sick += amm
	if sick >= 100:
		Achivements.full_sick()
	sick = clamp(sick,0,100)
	Global.UI.refreshHealth()

func eat(fd, amm, over = false, remove = true):
	var cal = Inventory.food[fd]["calories"]
	var space = self.maxFood - self.food
	if (space < cal and not over) or space == 0:
		return amm
	var wtr = 0
	if(Inventory.food[fd].has("water")):
		wtr = Inventory.food[fd]["water"]
	var ate = 0
	if(cal * amm <= space):
		ate = amm
		change_food(cal*amm,false)
		change_water(wtr*amm)
	else:
		var limit = 0 if over else cal
		while space > limit:
			space -= cal
			ate += 1
		change_food(cal*ate,false)
		change_water(wtr*amm)
	if Inventory.food[fd].has("sick"):
		change_sick(Inventory.food[fd]["sick"])
	if remove:
		Inventory.add_resource(fd,-ate,true)
	Global.Sound.play(Sound.UI_EATING, "SFX")
	return amm-ate
