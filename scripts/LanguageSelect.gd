extends Control

func _ready() -> void:
	var locale = getSettingsLocale();
	TranslationServer.set_locale(locale)
	
func _on_EN_pressed() -> void:
	GlobalConfig.set_language("en")

func _on_PL_pressed() -> void:
	GlobalConfig.set_language("pl")

func getSettingsLocale():
	var config = Save.loadConfig()
	if config and config.has("global") and config["global"].has("language") and config["global"]["language"] != null:
		return config["global"]["language"]
	else:
		return TranslationServer.get_locale()
