extends Control

export var dialogPath = ""
export var dialogId = ""
export (float) var baseTextSpeed = 0.05

var dialog: Array

var phraseNum = 0
var subphraseNum = 0
var current_split_phrase: Array #split into subphrases
var finished = false

export (Vector2) var char_size: Vector2 = Vector2(1, 1)

onready var label: RichTextLabel = $Text
onready var nb_chars_w: int = floor(label.rect_size.x / (char_size.x + 1)) - 1
onready var nb_chars_h: int = floor(label.rect_size.y / char_size.y)

func _ready():
	print(nb_chars_w)
	self.visible = false
	pass

func splitDialogBoxes(s: String) -> Array:
	var res = []
	var chars_on_line: int = 0
	var current_word_start: int = 0
	var last_word_end: int = 0
	var prev_char_was_space: bool = true
	var line_i: int = 0
	var i: int = 0
	var current_segment_start: int = 0
	
	while i < len(s):
		var c: int = s.ord_at(i)
		chars_on_line+=1
		if c == 32:
			if not prev_char_was_space:

				if chars_on_line - 1 > nb_chars_w:
					line_i += 1
					if line_i == 3:
						res.append(s.substr(current_segment_start, last_word_end - current_segment_start))
						current_segment_start = current_word_start
						line_i = 0
					chars_on_line = 1
					i = current_word_start
				else:
					last_word_end = i
					prev_char_was_space = true
		else:
			if prev_char_was_space:
				current_word_start = i
			prev_char_was_space = false
		i+= 1
	
	res.append(s.right(current_segment_start))
	return res

func startDialog(path: String, id: String, textSpeed: float = -1):
	if textSpeed == -1:
		textSpeed = baseTextSpeed
	$Timer.wait_time = textSpeed
	
	self.visible = true
	get_tree().paused = true
	
	dialog = get_dialog(path, id)
	phraseNum = 0
	startPhrase()

func quitDialog():
	self.visible = false
	reset_timer()
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


func reset_timer():
	$Timer.stop()

func displayCharacters():
	while label.visible_characters < len(label.text):
		if !visible or finished:
			$Timer.stop()
			return
		label.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	subphrase_end()

func subphrase_end():
	finished = true
	wait_for_input()
	pass
	
func wait_for_input():
	$Indicator.visible = true

func _input(event: InputEvent):
	if visible and event.is_action_pressed("ui_accept"):
		get_tree().set_input_as_handled()
		if finished:
			nextSubPhrase()
		else:
			label.visible_characters = len(label.text)
			subphrase_end()

func startSubPhrase():
	label.bbcode_text = current_split_phrase[subphraseNum]

	$Indicator.visible = false
	label.visible_characters = 0 
	finished = false

	displayCharacters()

func nextSubPhrase():
	subphraseNum += 1
	print(subphraseNum)
	if subphraseNum >= len(current_split_phrase):
		return nextPhrase()
	startSubPhrase()

func startPhrase():
	print("startPhrase")
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	var phraseText: String =  dialog[phraseNum]["Text"]

	current_split_phrase = splitDialogBoxes(phraseText)
	
	startSubPhrase()

func nextPhrase():
	print("nextPhrase")
	phraseNum += 1
	subphraseNum = 0
	if (phraseNum >= len(dialog)):
		quitDialog()
		return
	startPhrase()
	pass
