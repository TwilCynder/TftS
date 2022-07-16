extends Area2D

signal player_entered(player)

func _on_Area2D_area_entered(area):
	if (area is CenterArea and area.get_parent() is Player):
		emit_signal("player_entered", area.get_parent() as Player)

func _ready():
	#connect("area_entered", self, "_on_Area2D_area_entered")
	pass
