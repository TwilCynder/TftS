tool

extends Position2D

class_name Destination

export (String) var dest_name = "" setget set_name
export (bool) var default = false

func set_name(name: String) -> void:
	if Engine.editor_hint or dest_name == "" : 
		dest_name = name
		
func _ready():
	if Engine.editor_hint: return
	var SceneManager = get_node("/root/SceneManager")
	SceneManager.current_scene.add_destination(self, dest_name, default)
