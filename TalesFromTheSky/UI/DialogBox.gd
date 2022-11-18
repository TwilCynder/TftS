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
	if (phraseNum >= len(dialog)):
		return

	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Name.bbcode_text = dialog[phraseNum]["Text"]

	$Text.visible_characters = 0 

	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		yield($Timer, "timeout")
		
	finished = true
	phraseNum += 1
	return
