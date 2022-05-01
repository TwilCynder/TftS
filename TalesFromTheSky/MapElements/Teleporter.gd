tool

extends Area2D

export(String, FILE) var target_scene_path = ""
export(Vector2) var location = Vector2.ZERO

func _get_configuration_warning() -> String:
	if target_scene_path == "":
		return "No target scene specified (target_scene_path is empty)"
	else:
		return ""

func setPosition(player: Player):
	player.set_position(location)
	pass

func handlePosition(player: Player):
	print(location)

func _on_Portal_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		var tree = get_tree()
		if tree.change_scene(target_scene_path) != OK:
			print("Error : Unavailable scene : " + target_scene_path)
		else:
			var map = tree.root.get_child(0)
			if (map is Map):
				map = map as Map
				var hero = map.get_hero()
				if (hero is Player):
					handlePosition(hero)
