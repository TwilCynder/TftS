extends ColorRect

export var dialogPath = ""
export (float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = get_dialog()
	
func get_dialog() -> Array:
	return []

func nextPhrase():
	pass
