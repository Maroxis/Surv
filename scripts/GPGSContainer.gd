extends GridContainer

onready var sign_in: Control = $SignIn
onready var sign_out: Control = $SignOut
onready var achivements: Control = $Achivements
onready var leaderboards: Control = $Leaderboards

signal leaderBoardsPressed
signal signInPressed

func _ready() -> void:
#	if DevMode.on:
#		sign_out.show()
	return

func toggle(on):
	achivements.visible = on
	sign_in.visible = !on

func _on_SignInButton_pressed() -> void:
	if not ServiceManager.is_gpgs_available():
		return
	else:
		ServiceManager.sign_in()
	emit_signal("signInPressed")

func _on_ShowAchivementsButton_pressed() -> void:
	if ServiceManager.is_signed_in():
		ServiceManager.show_achivements()

func _on_LeaderBoardsButton_pressed() -> void:
	emit_signal("leaderBoardsPressed")

func _on_SignOutButton_pressed() -> void:
	if ServiceManager.is_signed_in():
		ServiceManager.sign_out()
