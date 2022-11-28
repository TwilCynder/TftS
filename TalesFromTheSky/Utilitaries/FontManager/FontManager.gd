tool

extends Node

var fonts: Dictionary

var theme: Theme = Theme.new()

func _add_font(font: TFont):
	if font.font == null:
		pass
	var name = font.font_name
	if name == "":
		name = font.name
	fonts[name] = font.font
	#theme.set_font(name, )

func get_font(name: String):
	return fonts.get("SoM")

func _ready():
	for node in get_children():
		if node is TFont:
			 _add_font(node as TFont)
