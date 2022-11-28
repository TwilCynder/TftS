tool

extends Node

class_name TFont

const alphabet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0.123456789.,/'\"$:-%!&?()£"

var font: BitmapFont
export (Texture) var texture: Texture = null
export (Vector2) var char_size: Vector2 = Vector2.ZERO
export (String) var font_name: String = ""

func _ready():
	load_font()

func load_font():
	
	font = BitmapFont.new()
	font.add_texture(texture)
	
	var tex_w: int = texture.get_size().x

	var region: Rect2 = Rect2(Vector2.ZERO, char_size)
	for c in alphabet:
		font.add_char(int(c), 0, region)
		region.position.x += char_size.x
		if region.position.x > tex_w:
			region.position.x = 0
			region.position.y += char_size.y
	

	
	
	
	
	
	
