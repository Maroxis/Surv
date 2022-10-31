extends Node

var play_games_services
var loaded_achivements = null
#var is_signed_in: bool = play_games_services.isSignedIn()
signal signedIn
signal signedOut

func _ready():
	# Check if plugin was added to the project
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_games_services = Engine.get_singleton("GodotPlayGamesServices")
	if not ServiceManager.is_gpgs_available():
		return
	# Initialize plugin by calling init method and passing to it a boolean to enable/disable displaying game pop-ups

	var show_popups := true
	var request_email := false
	var request_profile := false
	#The client id must be created in [the google console](https://console.cloud.google.com/apis/credentials), an OAuth 2.0 Client credentials of a Web application type
	var request_token := "124374767181-26amj6tvj7h63sk0nc56tngmm0kjs7k2.apps.googleusercontent.com"

	play_games_services.init(show_popups, request_email, request_profile, request_token)

	# For enabling saved games functionality use below initialization instead
	# play_games_services.initWithSavedGames(show_popups, "SavedGamesName", request_email, request_profile, request_token)

	# Connect callbacks (Use only those that you need)
	play_games_services.connect("_on_sign_in_success", self, "_on_sign_in_success") # account_id: String
	play_games_services.connect("_on_sign_in_failed", self, "_on_sign_in_failed") # error_code: int
	play_games_services.connect("_on_achievement_unlocked", self, "_on_achievement_unlocked") # achievement: String
	play_games_services.connect("_on_achievement_unlocking_failed", self, "_on_achievement_unlocking_failed") # achievement: String
#	play_games_services.connect("_on_achievement_revealed", self, "_on_achievement_revealed") # achievement: String
#	play_games_services.connect("_on_achievement_revealing_failed", self, "_on_achievement_revealing_failed") # achievement: String
	play_games_services.connect("_on_achievement_incremented", self, "_on_achievement_incremented") # achievement: String
	play_games_services.connect("_on_achievement_incrementing_failed", self, "_on_achievement_incrementing_failed") # achievement: String
	play_games_services.connect("_on_achievement_info_loaded", self, "_on_achievement_info_loaded") # achievements_json : String
	play_games_services.connect("_on_achievement_info_load_failed", self, "_on_achievement_info_load_failed")
	play_games_services.connect("_on_leaderboard_score_retrieved", self, "_on_leaderboard_score_retrieved") # playerstats: String (JSON)
	play_games_services.connect("_on_leaderboard_score_retrieve_failed", self, "_on_leaderboard_score_retrieve_failed") 
	play_games_services.connect("_on_leaderboard_score_submitted", self, "_on_leaderboard_score_submitted") # leaderboard_id: String
	play_games_services.connect("_on_leaderboard_score_submitting_failed", self, "_on_leaderboard_score_submitting_failed") # leaderboard_id: String
#	play_games_services.connect("_on_game_saved_success", self, "_on_game_saved_success") # no params
#	play_games_services.connect("_on_game_saved_fail", self, "_on_game_saved_fail") # no params
#	play_games_services.connect("_on_game_load_success", self, "_on_game_load_success") # data: String
#	play_games_services.connect("_on_game_load_fail", self, "_on_game_load_fail") # no params
#	play_games_services.connect("_on_create_new_snapshot", self, "_on_create_new_snapshot") # name: String
#	play_games_services.connect("_on_player_info_loaded", self, "_on_player_info_loaded")  # json_response: String
#	play_games_services.connect("_on_player_info_loading_failed", self, "_on_player_info_loading_failed")
#	play_games_services.connect("_on_player_stats_loaded", self, "_on_player_stats_loaded")  # json_response: String
#	play_games_services.connect("_on_player_stats_loading_failed", self, "_on_player_stats_loading_failed")

func _on_sign_in_success(_acc:String):
	play_games_services.loadAchievementInfo(false)
	emit_signal("signedIn")

func _on_sign_in_failed(err:int):
	print("Log in failed: ",err)
	emit_signal("signedOut")

func _on_achievement_unlocked(id : String):
	print("achivement unlocked: ",get_achivement(id)["name"])

func _on_achievement_unlocking_failed(id : String):
	print("achivement failed: ",get_achivement(id)["name"])

func _on_achievement_incremented(id : String):
	print("incremented: ", get_achivement(id)["name"])
	
func _on_achievement_incrementing_failed(id : String):
	print("inc failed: ", get_achivement(id)["name"])

func _on_achievement_info_loaded(achievements_json : String):
	loaded_achivements = parse_json(achievements_json)

func _on_achievement_info_load_failed(id : String):
	print("achivements loading failed: ",id)
	
func sign_in():
	play_games_services.signIn()

func sign_out():
	play_games_services.signOut()
	emit_signal("signedOut")

func show_achivements():
	play_games_services.showAchievements()

func is_signed_in():
	if is_gpgs_available():
		return play_games_services.isSignedIn()
	else:
		return false

func show_leaderboards():
	play_games_services.showAllLeaderBoards()

func is_gpgs_available():
	if play_games_services and play_games_services.isGooglePlayServicesAvailable():
		return true
	else:
#		print("no google services")
		return false

func unlock_achivement(id):
	if is_signed_in() and get_achivement(id)["state"] != 0:
		play_games_services.unlockAchievement(id)
		_set_unlocked(id)

func inc_achivement(id,step):
	var a = get_achivement(id)
	if is_signed_in() and a["state"] != 0:
		play_games_services.incrementAchievement(id, step)
		_set_achivement_key(id,"current_steps", a["current_steps"] + step)
		if a["current_steps"] + step >= a["total_steps"]:
			_set_unlocked(id)

func set_achivement_steps(id,amm):
	if amm < 0:
		return
	amm -= get_achivement(id)["current_steps"]
	if amm < 1:
		return
	inc_achivement(id,amm)

func reveal_achivement(id):
	play_games_services.revealAchievement(id)
	_set_revealed(id)

func _set_unlocked(id):
	if loaded_achivements == null:
		return false
	for a in loaded_achivements:
		if a["id"] == id:
			a["state"] = 0
			return true
	return false

func _set_revealed(id):
	if get_achivement(id)["state"] == 2:
		_set_achivement_key(id,"state",1)

func get_achivement(id):
	if loaded_achivements == null:
		return null
	for a in loaded_achivements:
		if a["id"] == id:
			return a
	return null

func _set_achivement_key(id,key,val):
	if loaded_achivements == null:
		return false
	for a in loaded_achivements:
		if a["id"] == id:
			a[key] = val
			return true
	return false

func add_highscore(time,difficulty):
	if difficulty == Difficulty.Normal:
		time = clamp(time,120,144000)
		play_games_services.submitLeaderBoardScore("CgkIzazBqs8DEAIQFw", time)
	elif difficulty == Difficulty.Hard:
		play_games_services.submitLeaderBoardScore("CgkIzazBqs8DEAIQGA", time)

func _on_leaderboard_score_retrieved(_playerstats: String):
	pass
func _on_leaderboard_score_retrieve_failed():
	pass
func _on_leaderboard_score_submitted(_leaderboard_id: String):
	pass
func _on_leaderboard_score_submitting_failed(_leaderboard_id: String):
	pass
