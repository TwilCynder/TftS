extends KinematicBody2D

#base code for enemies.

enum {
	FREE,
	KNOCKBACK,
	STATES
} #An enemy that has more states should extend this enmu using `enum {MYSTATE = STATES, ...}`

var state = FREE
var current_speed: Vector2 = Vector2.ZERO

var enemy_type = "Generic enemy"

onready var stats = $Stats

func _ready():
	pass # Replace with function body.

func die():
	print(enemy_type + " dies")
	queue_free()

func is_dying():
	return stats.hp < 1

func check_death():
	if is_dying():
		die()

func start_knockback(kb: Vector2) -> void:
	current_speed = kb
	state = KNOCKBACK

func _physics_process(delta):
	match state:
		KNOCKBACK:
			current_speed = current_speed.move_toward(Vector2.ZERO, stats.deceleration * delta)
			if current_speed == Vector2.ZERO:
				state = FREE
				#AI takes control again
			current_speed = move_and_slide(current_speed)
		FREE:
			check_death()

func get_hit(hitbox: Hitbox):
	if (hitbox.hitboxType == hitbox.HitboxType.SWORD):
		stats.decrease_hp()
		if hitbox.knockback and hitbox.knockback != Vector2.ZERO:
			start_knockback(hitbox.knockback * 100)
		else:
			check_death()

func _on_Hurtbox_hit(hitbox):
	get_hit(hitbox)
