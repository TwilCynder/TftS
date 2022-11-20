tool

extends Node2D

class_name Map

onready var Player = load("res://Player/Player.tscn")

var _destinations: Dictionary = {}
var default_destination: Destination = null

var hero = null

export(bool) var auto_hero = true #If true, a hero will be created automatically
export(String) var map_name = "" setget set_name, get_name

func get_name():
	return map_name

func set_name(name:String):
	if Engine.editor_hint or map_name == "": 
		map_name = name

# Called when the node enters the scene tree for the first time.
func _ready():
	print("> Generic map ready : ", map_name)
	if Engine.editor_hint: return
	if (auto_hero and not get_hero()):
		print("> Auto hero creation")
		var player = Player.instance()
		add_child(player)

func _enter_tree():
	print("> Map enter tree")
	
func add_destination(dest: Destination, name: String, default: bool = false) -> void:
	if (default_destination == null) or default:
		default_destination = dest
	_destinations[name] = dest
	
func get_destination(name: String) -> Destination:
	print(default_destination)
	if name == "": return default_destination
	return _destinations.get(name)
	
func set_hero(h: Player):
	assert(hero == null, "Attempted to set the curent Hero but it was already set")
	print("> Set hero : ", h)
	hero = h
		
func get_hero() -> Player:
	return hero
