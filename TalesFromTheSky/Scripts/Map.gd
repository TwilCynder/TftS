extends Node2D

class_name Map

onready var Player = load("res://Player/Player.tscn")

export(bool) var auto_hero = true #If true, a hero will be created automatically

var hero = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Generic map ready")
	if (auto_hero and not get_hero()):
		print("Auto hero creation")
		var player = Player.instance()
		add_child(player)
		set_hero(player)

func _enter_tree():
	pass
	
func set_hero(h: Player):
	assert(hero == null, "Attempted to set the curent Hero but it was already set")
	hero = h
		

func get_hero():
	return hero
