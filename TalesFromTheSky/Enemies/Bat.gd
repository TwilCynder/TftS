extends KinematicBody2D

enum {
	FREE,
	KNOCKBACK
}

var state = FREE
var knockback: Vector2 = Vector2.INF

onready var stats = $Stats

func _ready():	
	pass # Replace with function body.

#TODO : state machine
func _physics_process(delta):
	match state:
		KNOCKBACK:			
			knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
			if knockback == Vector2.ZERO:
				state = FREE
				#AI takes control again
			knockback = move_and_slide(knockback)
		FREE:
			check_death()

func die():
	print("Bat dies")
	queue_free()

func is_dying():
	return stats.hp < 1

func check_death():
	if is_dying():
		die()

func start_knockback(kb: Vector2) -> void:
	knockback = kb
	state = KNOCKBACK

func get_hit(hitbox: Hitbox):
	if (hitbox.hitboxType == hitbox.HitboxType.SWORD):
		stats.decrease_hp()
		if hitbox.knockback and hitbox.knockback != Vector2.ZERO:
			start_knockback(hitbox.knockback * 100)
		else:
			check_death()

#NOTES / TODO : utiliser la composition pour le knockback, par exemple un composant qui ajoute les fonctionnalités
# de knockback telles qu'implémentées actuellement dans cette fonction ? 

func _on_Hurtbox_area_entered(area):
	if (area is Hitbox):
		var hitbox: Hitbox = area as Hitbox
		get_hit(hitbox)
