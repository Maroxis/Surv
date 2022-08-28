extends Node

var thirstRate = 0.09 #per minute
var hungerRate = 0.03 #per minute
var regenRate = 0.01 #per minute
var exhaustRate = 0.1 #per minute
var sickRate = 0.002 #per minute
var dryRate = 0.4 #per minute

var maxWater = 100
var maxFood = 100
var maxHealth = 100
var maxEnergy = 100

var lowWarning = 10

var water = 40.0
var food = 80.0
var health = 100.0
var energy = 100.0

var sick = 0
var soaked = 0

func refresh_status():
	Global.UI.water.get_node("TextureProgress").animateValue(ceil(water))
	Global.UI.water.get_node("TextureProgress/Value").text = str(ceil(water))
	Global.UI.food.get_node("TextureProgress").animateValue(ceil(food))
	Global.UI.food.get_node("TextureProgress/Value").text = str(ceil(food))
	Global.UI.health.get_node("TextureProgress").animateValue(ceil(health))
	Global.UI.health.get_node("TextureProgress/Value").text = str(ceil(health))
	Global.UI.energy.get_node("TextureProgress").animateValue(ceil(energy))
	Global.UI.energy.get_node("TextureProgress/Value").text = str(ceil(energy))

func soak(amm):
	soaked += amm
	if(soaked > 100):
		change_sick(ceil((soaked-100) / 20))
		soaked = 100
	Global.Debug.soak_meter.value = soaked

func dry(time):
	if(Global.Weather.current == Global.Weather.type.Sunny):
		soaked -= dryRate*time*2
	else:
		soaked -= dryRate*time
	if(soaked < 0):
		soaked = 0
	Global.Debug.soak_meter.value = soaked

func change_water(amm, set = false):
	if(water == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		water = amm
	else:
		water += amm
	water = clamp(water,0,maxWater)
	_upd_water(amm)

func _upd_water(amm):
	Global.UI.water.get_node("TextureProgress").animateValue(ceil(water))
	if(water < lowWarning && amm < 0):
		Global.UI.water.get_node("TextureProgress").shake()
	Global.UI.water.get_node("TextureProgress/Value").text = str(ceil(water))
	
func upd_max_water(mx):
	maxWater += mx
	Global.UI.water.get_node("TextureProgress").max_value += mx
	
func change_food(amm, set = false):
	if(food == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		food = amm
	else:
		food += amm
	food = clamp(food,0,maxFood)
	Global.UI.food.get_node("TextureProgress").animateValue(ceil(food))
	if(food < lowWarning && amm < 0):
		Global.UI.food.get_node("TextureProgress").shake()
	Global.UI.food.get_node("TextureProgress/Value").text = str(ceil(food))
	
func change_health(amm, set = false):
	if(set):
		health = amm
	else:
		health += amm
	health = clamp(health,0,maxHealth)
	Global.UI.health.get_node("TextureProgress").animateValue(ceil(health))
	if(health < lowWarning && amm < 0):
		Global.UI.health.get_node("TextureProgress").shake()
	Global.UI.health.get_node("TextureProgress/Value").text = str(ceil(health))

func change_energy(amm, set = false):
	if(energy == 0 && amm < 0):
		change_health(amm/2)
	if(set):
		energy = amm
	else:
		energy += amm
	energy = clamp(energy,0,maxEnergy)
	Global.UI.energy.get_node("TextureProgress").animateValue(ceil(energy))
	if(energy < lowWarning && amm < 0):
		Global.UI.energy.get_node("TextureProgress").shake()
	Global.UI.energy.get_node("TextureProgress/Value").text = str(ceil(energy))

func sleep():
	var sleepTime = 360
	pass_time(sleepTime,true)
	
func pass_time(time,sleep=false,wet = false):
	var sleepMult = 1
	var sleepRegenMult = 1
	var sickPenaltyMlt = 1.0 if sick < 20 else 0.8
	var weatherPenalty = 1.2 if(Global.Weather.current == Global.Weather.type.Sunny) else 1.0
	var soakMult = Global.Weather.getRainInt()
	if(wet and soakMult > 0):
		soak(time*soakMult)
	elif(soaked > 0):
		dry(time)
	if(sleep):
		var ctier = Buildings.Structure["House"]["currentTier"]
		var houseb = Buildings.Structure["House"]["tier"+str(ctier)]["benefits"]
		sleepMult = houseb["sleepMult"]
		sleepRegenMult= houseb["sleepRegenMult"]
		change_energy(maxEnergy-sick)
	else:
		change_energy(-(time*exhaustRate*weatherPenalty))
		
	if(food > 50 && water > 30 && sick < 50):
		change_health(time*regenRate*sleepRegenMult*sickPenaltyMlt)
	elif(sick > 80):
		change_health(-(time*regenRate))
	change_water(-(time*thirstRate*sleepMult*sickPenaltyMlt*sickPenaltyMlt*weatherPenalty))
	change_food(-(time*hungerRate*sleepMult*sickPenaltyMlt))
	
	if(sick > 0):
		var fullBonus = 2 if food > 50 and water > 50 else 1
		change_sick(-(sickRate*time*sleepRegenMult*fullBonus))

	Buildings.runCollector(time)
	Global.Smelt.run(time)
	Global.Date.changeTime(time)
	Global.Weather.simWeather(time)
	
func change_sick(amm):
	sick += amm
	sick = clamp(sick,0,100)
	Global.UI.health.get_node("SickProgress").animateValue(ceil(sick))
	
