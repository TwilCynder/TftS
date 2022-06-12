extends Teleporter_base


func _on_Teleporter_base_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		_teleport()
