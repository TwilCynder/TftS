tool

extends Area2D

export(String, FILE) var target_scene_path = ""
export(Vector2) var location = Vector2.ZERO

func _get_configuration_warning() -> String:
	if target_scene_path == "":
		return "No target scene specified (target_scene_path is empty)"
	else:
		return ""

func _setPosition(player: Player) -> void:
	print(location)
	player.set_position(location)

func _handlePosition(tree: SceneTree) -> void:
	yield(SceneManager, "scene_loaded")
	var player: Player = SceneManager.current_scene.get_hero()
	if not player:
		print("WARNING : Map where we teleported to has no hero (maybe check Auto Hero ?)")
		return
	player.position = location


func _teleport():
	
	var tree = get_tree()
	SceneManager.change_scene(target_scene_path)
	_handlePosition(tree)


func _on_Portal_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		_teleport()
