extends "res://MapElements/Teleporter_base.gd"

#class_name TeleporterDestination

export(String) var destination = ""

func _setPosition(player: Player):
	var destination_: Destination = SceneManager.current_scene.get_destination(destination)
	assert (destination_ != null, "Destination not found : " + destination)
	
	player.position = destination_.position
	
	player.get_parent().remove_child(player)
	destination_.get_parent().add_child(player)
