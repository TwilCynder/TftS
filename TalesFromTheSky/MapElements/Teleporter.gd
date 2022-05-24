tool

extends Area2D

export(String, FILE) var target_scene_path = ""
export(Vector2) var location = Vector2.ZERO

func _get_configuration_warning() -> String:
	if target_scene_path == "":
		return "No target scene specified (target_scene_path is empty)"
	else:
		return ""

func _setPosition(player: Player):
	print(location)
	player.set_position(location)

func _handlePosition(tree: SceneTree):
	var map = tree.root.get_child(0)
	if (map is Map):
		map = map as Map
		print("Map name : " + map.map_name)
		var hero = map.get_hero()
		_setPosition(hero)

func _start_teleport_animation():
	SceneManager.change_scene(target_scene_path)

func _teleport():
	
	var tree = get_tree()
	if tree.change_scene(target_scene_path) == OK:
		_handlePosition(tree)
	else:
		print("Error : Unavailable scene : " + target_scene_path)


func _on_Portal_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		_start_teleport_animation()
