tool

extends Node

class_name DialogStarter

export (String, FILE, "*.json") var path = ""
export (String) var id = "" 

func _get_configuration_warning() -> String:
	if path == "":
		return "Empty dialog path"
	else:
		return ""

	if id == "":
		return "Empty dialog ID"
	else:
		return ""

func _startDialog():
	DialogBox.startDialog(path, id)


func _on_LookInteractionBox_hero_interact(hero: Player):
	hero.setAnimation("Idle")
	_startDialog()
