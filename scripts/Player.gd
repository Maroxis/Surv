extends Node

#0.07 ~= 100 per day
var thirstRate = 0.14 #per minute
var hungerRate = 0.07 #per minute
var regenRate = 0.01 #per minute
var exhaustRate = 0.08 #per minute
var sickRate = 0.002 #per minute
var dryRate = 0.4 #per minute

var maxWater = 100
var maxFood = 100
var maxHealth = 100
var maxEnergy = 100

var lowWarning = 15

var water = 40.0
var food = 80.0
var health = 100.0
var energy = 100.0

var sick = 0
var soaked = 0

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
	return dict

func unpack(dict):
	maxWater = dict["maxWater"]
	maxFood = dict["maxFood"]
	maxHealth = dict["maxHealth"]
	maxEnergy = dict["maxEnergy"]
	water = dict["water"]
	food = dict["food"]
	health = dict["health"]
	energy = dict["energy"]
	sick = dict["sick"]
	soaked = dict["soaked"]

func refresh_status():
	Global.UI.water.get_node("TextureProgress").animateValue(ceil(water))
	Global.UI.water.get_node("TextureProgress/Value").text = str(ceil(water))
	Global.UI.food.get_node("TextureProgress").animateValue(ceil(food))
	Global.UI.food.get_node("TextureProgress/Value").text = str(ceil(food))
	Global.UI.health.get_node("TextureProgress").animateValue(ceil(health))
	Global.UI.health.get_node("TextureProgress/Value").text = str(ceil(health))
	Global.UI.health.get_node("SickProgress").animateValue(ceil(sick))
	Global.UI.energy.get_node("TextureProgress").animateValue(ceil(energy))
	Global.UI.energy.get_node("TextureProgress/Value").text = str(ceil(energy))

func soak(amm):
	soaked += amm
	if(soaked > 100):
		change_sick(ceil((soaked-100) / 20))
		soaked = 100
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
		change_health(amm)
	if(set):
		water = amm
	else:
		water += amm
	water = clamp(water,0,maxWater)
	_upd_water(amm)

func _upd_water(amm):
	Global.UI.water.get_node("TextureProgress").animateValue(ceil(water))
	if(water < lowWarning && amm < 0):
		Global.UI.water.shake()
	Global.UI.water.get_node("TextureProgress/Value").text = str(ceil(water))
	
func upd_max_water(mx):
	maxWater += mx
	Global.UI.water.get_node("TextureProgress").max_value += mx
	
func change_food(amm, set = false, over = false):
	if(amm == 0 and not set):
		return
	if(food == 0 && amm < 0):
		change_health(amm*2)
	if(set):
		food = amm
	else:
		food += amm
	if not over:
		food = clamp(food,0,maxFood)
	Global.UI.food.get_node("TextureProgress").animateValue(ceil(food))
	if(food < lowWarning && amm < 0):
		Global.UI.food.shake()
	Global.UI.food.get_node("TextureProgress/Value").text = str(ceil(food))
	
func change_health(amm, set = false):
	if(amm == 0 and not set):
		return
	if(set):
		health = amm
	else:
		health += amm
	health = clamp(health,0,maxHealth)
	Global.UI.health.get_node("TextureProgress").animateValue(ceil(health))
	if(health < lowWarning && amm < 0):
		Global.UI.health.shake()
	Global.UI.health.get_node("TextureProgress/Value").text = str(ceil(health))
	if(health <= 0):
		Global.GameOver.init()

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
		Global.UI.energy.shake()
	Global.UI.energy.get_node("TextureProgress/Value").text = str(ceil(energy))

func sleep():
	var sleepTime = 360
	pass_time(sleepTime,true)
	
func pass_time(time,sleep=false,wet = false):
	time = int(time)
	var sleepRegenMult = 1
	var sickPenaltyMlt = 1.0 if sick < 20 else 0.8
	var weatherPenalty = 1.2 if(Global.Weather.current == Global.Weather.type.Sunny) else 1.0
	var soakMult = Global.Weather.getRainInt()
	if(wet and soakMult > 0):
		soak(time*soakMult)
	elif(soaked > 0):
		dry(time)
	if(sleep):
		var houseb = Buildings.getCurrentModule("House","Bed")["benefits"]
		sleepRegenMult= houseb["sleepRegenMult"]
		change_energy(maxEnergy-sick)
	else:
		change_energy(-(time*exhaustRate*weatherPenalty))
		
	if(food > 50 && water > 30 && sick < 50):
		change_health(time*regenRate*sleepRegenMult*sickPenaltyMlt)
	elif(sick > 80):
		change_health(-(time*regenRate))
	change_water(-(time*thirstRate*sickPenaltyMlt*sickPenaltyMlt*weatherPenalty))
	change_food(-(time*hungerRate*sickPenaltyMlt))
	
	if(sick > 0):
		var fullBonus = 2 if food > 50 and water > 50 else 1
		change_sick(-(sickRate*3*time*sleepRegenMult*fullBonus))
	
	Buildings.runCollector(time)
	Inventory.spoil_food(time)
	Global.Smelt.run(time)
	Global.Cook.run(time)
	Global.Weather.simWeather(time)
	Global.Date.changeTime(time)
	
func change_sick(amm):
	sick += amm
	sick = clamp(sick,0,100)
	Global.UI.health.get_node("SickProgress").animateValue(ceil(sick))
	Global.UI.health.get_node("SickProgress").flashBar(sick > 80)

func eat(fd, amm, over = false, remove = true):
	var cal = Inventory.food[fd]["calories"]
	var space = self.maxFood - self.food
	if (space < cal and not over) or space == 0:
		return amm
	var wtr = 0
	if(Inventory.food[fd].has("water")):
		wtr = Inventory.food[fd]["calories"]
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
	return amm-ate
