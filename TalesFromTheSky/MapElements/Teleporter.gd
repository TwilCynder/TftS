tool

extends Area2D

var Player = load("res://Player/Player.gd")

export(String, FILE) var target_scene_path = ""

func _get_configuration_warning() -> String:
	if target_scene_path == "":
		return "No target scene specified (target_scene_path is empty)"
	else:
		return ""



func _on_Portal_body_entered(body):
	if (body is Player):
		if get_tree().change_scene(target_scene_path) != OK:
			print("Error : Unavailable scene : " + target_scene_path)
