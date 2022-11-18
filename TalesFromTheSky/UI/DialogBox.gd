extends ColorRect

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

func get_dialog(path: String, id: String) -> Array:
	
	var f = File.new()
	assert(f.file_exists(dialogPath), "Dialog path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	var dialogs = JSON.parse(json).result
	
	if typeof(dialogs) == TYPE_DICTIONARY:
		print("Ma bite")
	
	return []
	
func _process(delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func nextPhrase():
	if (phraseNum >= len(dialog)):
		self.visible = false
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
