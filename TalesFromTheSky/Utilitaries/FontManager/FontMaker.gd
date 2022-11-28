tool

extends Node

class_name FontMaker

var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,/'\"$:-%!&?()£\u0001\u0002\u0003\u0004\u0005 "

var font: BitmapFont

export (Texture) var texture: Texture = null
export (bool) var run: bool = false setget __run
export (String, DIR) var save_directory  = ""
export (String) var file_name = ""
export (Vector2) var char_size = Vector2.ZERO

func __run(_d: bool):
	_run()

func _run():
	if texture != null:
		load_font(texture)

func show_dialog():
	var dialog: EditorFileDialog = EditorFileDialog.new()
	dialog.window_title = "Select place to save to"
	dialog.resizable = true
	dialog.add_filter("*.fnt ; Font")
	dialog.mode = EditorFileDialog.MODE_SAVE_FILE
	
	dialog.visible = true

func save_font():
	ResourceSaver.save(save_directory + "/" + file_name + ".tres", font, 4)
	
func load_font(path: Texture):
	show_dialog()
	
	font = BitmapFont.new()
	font.add_texture(texture)
	
	var tex_w: int = texture.get_size().x

	var region: Rect2 = Rect2(Vector2.ZERO, char_size)
	var array: PoolByteArray = alphabet.to_ascii()
	for c in array:
		font.add_char(c, 0, region, Vector2.ZERO, char_size.x + 1)
		print(c, region)
		region.position.x += char_size.x
		if region.position.x >= tex_w:
			region.position.x = 0
			region.position.y += char_size.y
	font.height = char_size.y
	save_font()
	
	
	
	
	
	
