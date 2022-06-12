tool

extends Node2D

class_name Teleporter_base

export(String, FILE) var target_scene_path = ""

func _exit_tree():
	print("> Teleporter exits tree")

func _get_configuration_warning() -> String:
	if target_scene_path == "":
		return "No target scene specified (target_scene_path is empty)"
	else:
		return ""

func _setPosition(player: Player):
	pass

func _handlePosition(tree: SceneTree) -> void:
	var player: Player = SceneManager.current_scene.get_hero()
	print(SceneManager.current_scene._destinations)
	if not player:
		print("WARNING : Map where we teleported to has no hero (maybe check Auto Hero ?)")
		return
	_setPosition(player)


func _teleport():
	var tree = get_tree()
	SceneManager.enter_limbo(self)
	SceneManager.change_scene(target_scene_path)
	yield(SceneManager, "scene_loaded")
	_handlePosition(tree)
