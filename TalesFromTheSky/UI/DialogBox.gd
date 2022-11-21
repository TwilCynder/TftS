extends Control

export var dialogPath = ""
export var dialogId = ""
export (float) var baseTextSpeed = 0.05

var dialog: Array

var phraseNum = 0
var finished = false

var char_height: int = 12
var char_width: int = 12
onready var nb_chars_w: int = floor($Text.rect_size.x / char_width)
onready var nb_chars_h: int = floor($Text.rect_size.y / char_height)

func _ready():
	self.visible = false
	pass

func splitDialogBoxes(s: String):
	var res = []
	var chars_on_line: int = 0
	var previous_word_start: int = 0
	var last_word_end: int = 0
	var prev_char_was_space: bool = true
	var line_i: int = 0
	var i: int = 0
	var current_segment_start: int = 0
	while i < len(s):
		var c: int = s.ord_at(i)
		print(s.substr(i, 1))
		chars_on_line+=1
		if c == 32:
			if not prev_char_was_space:
				last_word_end = i - 1
			prev_char_was_space  = true
		else:
			if prev_char_was_space:
				previous_word_start = i
				print("Prev was space")
				if chars_on_line > nb_chars_w:
					print("Dépassement ligne", chars_on_line, i)
					line_i += 1
					if line_i == 3:
						res.append(s.substr(current_segment_start, last_word_end - current_segment_start + 1))
						current_segment_start = i
						line_i = 0
					chars_on_line = 0
					print("Previous word start : ", previous_word_start)
					i = previous_word_start
					previous_word_start = 0
				else:
					previous_word_start == i
			prev_char_was_space = false
		i+= 1
	
	res.append(s.right(current_segment_start))
	return res

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

func is_out_of_limits(nb_chars: int):
	return 

func displayCharacters():
	while $Text.visible_characters < len($Text.text):
		if !visible or finished:
			$Timer.stop()
			return
		$Text.visible_characters += 1
		if $Text.get_visible_line_count() > nb_chars_h:
			$Text.visible_characters -= 2
			
			$Timer.stop()
			#$Text.scroll_to_line(2)
			return
		
		$Timer.start()
		yield($Timer, "timeout")

func onLimitReached():
	finished = true

func nextPhrase():
	
	if (phraseNum >= len(dialog)):
		quitDialog()
		return


	$Name.bbcode_text = dialog[phraseNum]["Name"]
	var phraseText: String =  dialog[phraseNum]["Text"]

	print(splitDialogBoxes(dialog[phraseNum]["Text"]))

	$Text.bbcode_text = phraseText

	$Text.visible_characters = 0 

	displayCharacters()
	
	return
