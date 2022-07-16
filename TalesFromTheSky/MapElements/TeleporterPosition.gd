tool

extends "res://MapElements/Teleporter_base.gd"

class_name TeleporterPosition

export(Vector2) var location = Vector2.ZERO

func _setPosition(player: Player):
	player.position = location
	print("> TeleporterPosition setPosition with " + str(location))
