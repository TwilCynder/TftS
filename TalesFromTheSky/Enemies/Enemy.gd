extends KinematicBody2D

#base code for enemies.

class_name Enemy

enum {
	FREE,
	KNOCKBACK,
	STATES
} #An enemy that has more states should extend this enum using `enum {MYSTATE = STATES, ...}` 
#wow j'ai vraiment inventé ça ? si c'est le cas gg twil d'il y a 2 semaines

var state = FREE
var current_speed: Vector2 = Vector2.ZERO

var enemy_type = "Generic enemy"

onready var stats = $Stats

var DeathEffect = preload("res://Effects/EnemyDeath.tscn")
var AI = load("res://Enemies/AI/basic_AI.gd")

var ai: AI

func findAINode():
	for n in get_children():
		if n is AI:
			ai = n as AI

func _ready():
	findAINode()
	print(ai)
	pass # Replace with function body.

func die():
	print(enemy_type + " dies")
	AnimatedEffect.displayEffect(DeathEffect.instance(), self.position)
	queue_free()
	GameEvents.emit_signal("enemy_dies", self)

func is_dying():
	return stats.hp < 1

func check_death():
	if is_dying():
		die()

func start_knockback(kb: Vector2) -> void:
	current_speed = kb
	state = KNOCKBACK
	
func _process(delta):
	ai.process(delta)

func _physics_process(delta):
	match state:
		KNOCKBACK:
			current_speed = current_speed.move_toward(Vector2.ZERO, stats.deceleration * delta)
			if current_speed == Vector2.ZERO:
				state = FREE
				#AI takes control again
			else:
				current_speed = move_and_slide(current_speed)
		FREE:
			ai.physics_process(delta)
			current_speed = move_and_slide(current_speed)
			check_death()

func get_hit(hitbox: DamageHitbox, hurtbox: Hurtbox):
	stats.remove_hp(hitbox.damage)
	if hitbox.knockback:
		start_knockback(hitbox.computeEffectiveKnockback(hurtbox.global_position))
	else:
		check_death()

func _on_Hurtbox_hit(hitbox, hurtbox):
	if (hitbox.hitboxType == hitbox.HitboxType.SWORD and hitbox is DamageHitbox):
		get_hit(hitbox, hurtbox)
