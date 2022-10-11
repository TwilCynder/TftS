extends MapEntity

enum {
	FREE,
	ATTACK,
	KNOCKBACK
}

class_name Player

signal interact()

export(bool) var allow_redundancy = false #If unchecked, delete the hero if there is another on the same Map ? (typically on maps with Auto Hero)
export(bool) var use_as_default_destination = true #If checked, will

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/Swordhitbox
onready var collisionBox = $CollisionBox

var TreeUtil = load("res://Utilitaries/TreeUtil.gd")

func _enter_tree():
	print("> Player enter tree")

			
func _ready():
	print("> Hello there ! (Player ready)")
	
	var root = SceneManager.current_scene
	assert(root != null, "Can't find root node")
	if root.get_hero():
		if not allow_redundancy:
			print("> Deleting this Player because the map already has a hero")
			get_parent().remove_child(self)
			queue_free()
	else:
		root.set_hero(self)
	
	animationTree.active = true
	
const WALK_SPEED = 100
var ACCELERATION = 200

var state = FREE
var velocity = Vector2.ZERO #Current move speed (input_vector * WALK_SPEED when moving in FREE state)
var input_vector = Vector2.ZERO 
var direction: Vector2 = Vector2.RIGHT #last non-zero value input_vector had in FREE state
#var direction = "Right"

func is_looking_at(point: Vector2)->bool:
	return Util.is_same_direction4(direction, point - position)

func is_looking_towards(point: Vector2)->bool:
	return Util.is_similar_direction4(direction, point - position)

func start_state_attack():
	state = ATTACK
	setAnimation("Attack")
	swordHitbox.knockback = direction

func start_state_free():
	state = FREE

func attack_animation_finished():
	start_state_free()
	swordHitbox.knockback = null

func _process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.on_hero_interact(self)

func _physics_process(delta: float):
	match state:
		FREE:	
			free_state(delta)
		ATTACK:
			attack_state(delta)
		
func attack_state(delta):
	pass
		
func setAnimation(anim: String):
	animationState.travel(anim)
	animationTree.set("parameters/" + anim + "/blend_position", direction)
		
func setAnimDirection(input_vector):
	animationTree.set("parameters/Idle/blend_position", input_vector)
	animationTree.set("parameters/Run/blend_position", input_vector)
	animationTree.set("parameters/Attack/blend_position", input_vector)
		
func free_state(delta):
	#==== THE SHORT AND SIMPLE WAY
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		direction = input_vector
		setAnimation("Run")
	else:
		setAnimation("Idle")
		
	velocity = input_vector * WALK_SPEED
	move_and_slide(velocity)

	if Input.is_action_just_pressed("attack"):
		start_state_attack()
		
func get_direction()->Vector2:
	return direction
		


func _on_Hurtbox_hit(hitbox, hurtbox):
	pass
