tool

extends "res://MapElements/NPC/NPC.gd"

export (Direction.dirs) var direction: int = Direction.RIGHT setget _set_direction 

export (String) var animation: String = "standing"
export (bool) var directional_animation: bool = true

onready var anim_full_name: String = get_animation_name(animation, direction, directional_animation) #setget ,_get_direction_name

static func get_animation_name(anim: String, direction: int, directional: bool):
	if directional:
		return anim + "_" + Direction.direction4_to_directionName_assert(direction)
	else:
		return anim

func set_animation(anim: String, directional: bool = true):
	animation = anim
	directional_animation = directional
	anim_full_name = get_animation_name(anim, direction, directional)


func _set_direction(dir: int):
	if dir != direction:
		anim_full_name = get_animation_name(animation, dir, directional_animation)
	direction = dir

func updateAnimatedSprite():
	$AnimatedSprite.animation = anim_full_name

#inutilisée atm, utile que si c mieux de mettre ça en getter de direction_name que de mettre un setter sur direction
func _get_direction_name() -> String:
	return get_animation_name(animation, direction, directional_animation)
