extends Node2D

signal scene_unloaded
signal scene_loaded
signal player_interact(hero)

onready var _tree = get_tree()
onready var transition_fade = $CanvasLayer/SceneTransitionRect
onready var current_scene: Map = get_current_scene()
var hero: Player setget set_hero, get_hero
onready var limbo = $Limbo

func get_current_scene():
	if _tree.current_scene is Map:
		return _tree.current_scene
	else:
		return null

func get_hero():
	if current_scene == null:
		return null
	else:
		return current_scene.get_hero()
	
func set_hero(hero: Player):
	current_scene.set_hero(hero)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("> SceneManager Ready")
	if not (current_scene is Map):
		print("WARNING : Current scene is not a map")

func _enter_tree():
	print("> SceneManager enters tree")

func test():
	print("Singleton Test")

#TODO changer le moment où la scene est chargée
func change_scene(path) -> void:
	transition_fade.start_transition()
	yield(transition_fade, "transition_middle")
	_replace_scene(path)

static func load_map(path: String) -> Map:
	var map_scene = ResourceLoader.load(path)
	assert(map_scene is PackedScene, "Can't load map " + path + "; file is not a Scene.")
	var map =  map_scene.instance()
	assert(map is Map, "The root node of the loaded scene is not a Map")
	return map

func _replace_scene(path: String) -> void:
	print("> Initiating scene change")
	
	emit_signal("scene_unloaded")
	var new_scene = load_map(path)
	_tree.current_scene.queue_free()
	
	yield(_tree, "idle_frame")
	
	print("> Swapping scenes")
	current_scene = new_scene
	_tree.get_root().add_child(current_scene)
	_tree.set_current_scene(current_scene)
	current_scene.map_name = path
	
	emit_signal("scene_loaded")
	
	for node in limbo.get_children():
		limbo.remove_child(node)
		
func enter_limbo(node: Node) -> void:
	node.get_parent().remove_child(node)
	limbo.add_child(node)
	
func on_hero_interact(hero: Player):
	emit_signal("player_interact", hero)

