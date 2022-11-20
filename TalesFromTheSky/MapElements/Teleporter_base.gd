tool

extends Node2D

#class_name Teleporter_base

export(String, FILE, "*.tscn") var target_scene_path = ""
#export(PackedScene) var target_scene

func _exit_tree():
	print("> Teleporter exits tree")

func _get_configuration_warning() -> String:
	if target_scene_path == "":
		return "No target scene specified (target_scene_path is empty)"
	else:
		return ""

func _setPosition(player: Player):
	print("> TP_base setPosition (SHOULD NEVER BE CALLED)")

func _handlePosition() -> void:
	var player: Player = SceneManager.current_scene.get_hero()
	if not player:
		print("WARNING : Map where we teleported to has no hero (maybe check Auto Hero ?)")
		return
	_setPosition(player)


func _teleport():
	assert(target_scene_path != "", "Teleporter's target scene path is empty")
	SceneManager.enter_limbo(self)
	SceneManager.change_scene(target_scene_path)
	yield(SceneManager, "scene_loaded")
	_handlePosition()
