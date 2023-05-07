extends Node
var data = {
	'language': null
}

func pack():
	return data

func set_language(lg):
	TranslationServer.set_locale(lg)
	data["language"] = lg
	Save.saveConfig()
