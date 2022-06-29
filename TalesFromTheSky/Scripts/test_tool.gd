tool
extends Sprite

class_name test_tool

export var speed = 1 setget set_speed

# Update speed and reset the rotation.
func set_speed(new_speed):
	speed = new_speed
	rotation_degrees = 0
	print("oui")

func _process(delta):
	if Engine.editor_hint:
		rotation_degrees += 180 * delta
	else:
		rotation_degrees -= 180 * delta
