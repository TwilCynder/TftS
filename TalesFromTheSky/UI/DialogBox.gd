extends Control

export var dialogPath = ""
export var dialogId = ""
export (float) var baseTextSpeed = 0.05

var dialog: Array

var phraseNum = 0
var finished = false

func _ready():
	self.visible = false
	pass

func startDialog(path: String, id: String, textSpeed: float = -1):
	if textSpeed == -1:
		textSpeed = baseTextSpeed
	$Timer.wait_time = textSpeed
	dialog = get_dialog(path, id)
	self.visible = true
	get_tree().paused = true
	nextPhrase()

func quitDialog():
	self.visible = false
	get_tree().paused = false
	
func get_dialog(path: String, id: String) -> Array:
	var f = File.new()
	assert(f.file_exists(path), "Dialog path does not exist")

	f.open(path, File.READ)
	var json = f.get_as_text()
	var dialogs = JSON.parse(json).result
	
	match typeof(dialogs):
		TYPE_DICTIONARY:
			return dialogs[id]
		TYPE_ARRAY:
			return dialogs
		0:	
			assert(false, "Invalid dialog file " + path + " " + id)
	
	assert(false, "Invalid dialog type " + path + " " + id)
	return []
	
func _input(event: InputEvent):
	$Indicator.visible = finished
	if event.is_action_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func reset_timer():
	$Timer.stop()

func nextPhrase():
	
	if (phraseNum >= len(dialog)):
		quitDialog()
		return

	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]

	$Text.visible_characters = 0 

	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		$Timer.start()
		yield($Timer, "timeout")
		
	finished = true
	phraseNum += 1
	return
