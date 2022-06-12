extends Position2D

class_name Destination

export (String) var dest_name = ""

func _ready():
	var SceneManager = get_node("/root/SceneManager")
	SceneManager.current_scene.add_destination(self, dest_name)
