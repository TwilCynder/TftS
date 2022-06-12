extends TeleporterPosition

func _on_TeleporterPosition_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		_teleport()
