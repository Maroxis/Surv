extends Node

enum {Normal = 1, Hard = 2}
var current

func is_normal():
	return self.current == self.Normal

#Player
func get_soak_limit():
	return 100 if is_normal() else 60

func get_health_regen_multiplayer():
	return 1.0 if is_normal() else 0.8
func get_health_damage_multiplayer():
	return 0.8 if is_normal() else 1.0

func get_sick_gain_multiplayer():
	return 0.8 if is_normal() else 1.4
func get_sick_reduction_multiplayer():
	return 1.6 if is_normal() else 0.8

#Events
func get_starting_tool_dmg_mlt():
	return 0.8 if is_normal() else 1.4
func get_scaling_tool_dmg():
	return 0.2 if is_normal() else 0.4

func get_starting_water_add_time():
	return 25 if is_normal() else 55
func get_scaling_water_add_time():
	return 10 if is_normal() else 25

func get_woods_travel_add_time():
	return 30 if is_normal() else 50

func get_sick_mlt():
	return clamp(Global.Date.day/12,1.0,6.0) if is_normal() else clamp(Global.Date.day/8,1.2,8.0)

func get_attack_val():
	var rl = rand_range(0.9,1.1)
	return ceil((Global.Date.day/6.6)*rl) if is_normal() else ceil((Global.Date.day/4.0)*rl)

func get_spooked_animals_mlt():
	return ceil(Global.Date.getDay() / 22.0) if is_normal() else ceil(Global.Date.getDay() / 18.0)

func get_cave_in_amm():
	return ceil(Global.Date.getDay() / 10.0) if is_normal() else ceil(Global.Date.getDay() / 8.0)

func get_rats_amm():
	return int(clamp(Global.Date.day/9.0,1.0,12.0)) if is_normal() else int(clamp(Global.Date.day/7.0,1.0,22.0))
