extends "res://MapElements/TeleporterDestination.gd"

func _on_TeleporterDestination_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		_teleport()
