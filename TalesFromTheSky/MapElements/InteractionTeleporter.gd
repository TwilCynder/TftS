extends LookInteractionBox

onready var teleporter = $Teleporter

func _ready():
	if teleporter == null:
		for n in get_children():
			if n.name.begins_with("Teleporter"):
				teleporter = n
				break

func _on_InteractionTeleporter_hero_interact(hero):
	teleporter._teleport()
