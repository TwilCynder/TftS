tool

extends Position2D

class_name Destination

export (String) var dest_name = ""
export (bool) var default = false 

func _ready():
	var SceneManager = get_node("/root/SceneManager")
	SceneManager.current_scene.add_destination(self, dest_name)
	
