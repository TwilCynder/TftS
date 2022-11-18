extends CanvasLayer

onready var dialog_box = $DialogBox

func startDialog(path: String, id: String, textSpeed: float = -1):
	print("Start dialog :)")
	dialog_box.startDialog(path, id, textSpeed)
