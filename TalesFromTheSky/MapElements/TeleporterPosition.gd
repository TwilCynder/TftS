extends Teleporter_base

class_name TeleporterPosition

export(Vector2) var location = Vector2.ZERO

func _setPosition(player: Player):
	player.position = location
