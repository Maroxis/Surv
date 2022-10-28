extends Node

var play_games_services
#var is_signed_in: bool = play_games_services.isSignedIn()
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
#	play_games_services.connect("_on_achievement_incremented", self, "_on_achievement_incremented") # achievement: String
#	play_games_services.connect("_on_achievement_incrementing_failed", self, "_on_achievement_incrementing_failed") # achievement: String
	play_games_services.connect("_on_achievement_info_loaded", self, "_on_achievement_info_loaded") # achievements_json : String
	play_games_services.connect("_on_achievement_info_load_failed", self, "_on_achievement_info_load_failed")
#	play_games_services.connect("_on_leaderboard_score_retrieved", self, "_on_leaderboard_score_retrieved") # playerstats: String (JSON)
#	play_games_services.connect("_on_leaderboard_score_retrieve_failed", self, "_on_leaderboard_score_retrieve_failed") 
#	play_games_services.connect("_on_leaderboard_score_submitted", self, "_on_leaderboard_score_submitted") # leaderboard_id: String
#	play_games_services.connect("_on_leaderboard_score_submitting_failed", self, "_on_leaderboard_score_submitting_failed") # leaderboard_id: String
#	play_games_services.connect("_on_game_saved_success", self, "_on_game_saved_success") # no params
#	play_games_services.connect("_on_game_saved_fail", self, "_on_game_saved_fail") # no params
#	play_games_services.connect("_on_game_load_success", self, "_on_game_load_success") # data: String
#	play_games_services.connect("_on_game_load_fail", self, "_on_game_load_fail") # no params
#	play_games_services.connect("_on_create_new_snapshot", self, "_on_create_new_snapshot") # name: String
#	play_games_services.connect("_on_player_info_loaded", self, "_on_player_info_loaded")  # json_response: String
#	play_games_services.connect("_on_player_info_loading_failed", self, "_on_player_info_loading_failed")
#	play_games_services.connect("_on_player_stats_loaded", self, "_on_player_stats_loaded")  # json_response: String
#	play_games_services.connect("_on_player_stats_loading_failed", self, "_on_player_stats_loading_failed")

func _on_sign_in_success(acc:String):
#	Global.InGSettings.set_gpgs_autostart(true)
	print("Succes: ",acc)

func _on_sign_in_failed(err:int):
#	Global.InGSettings.set_gpgs_autostart(false)
	print("Error: ",err)

func _on_achievement_unlocked(id : String):
	print("achivement unlocked: ",id)

func _on_achievement_unlocking_failed(id : String):
	print("achivement failed: ",id)

func _on_achievement_info_loaded(achivements : String):
	print("achivements: ",achivements)

func _on_achievement_info_load_failed(id : String):
	print("achivements failed: ",id)

func sign_in():
	play_games_services.signIn()

func show_achivements():
	print("aaa")
#	play_games_services.unlockAchievement("CgkIzazBqs8DEAIQFg")
	play_games_services.showAchievements()
func is_signed_in():
	if is_gpgs_available():
		return play_games_services.isSignedIn()
	else:
		return false
func is_gpgs_available():
	if play_games_services and play_games_services.isGooglePlayServicesAvailable():
		return true
	else:
		print("no google services")
		return false
