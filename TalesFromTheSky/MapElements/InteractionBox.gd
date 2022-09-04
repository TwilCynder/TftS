extends Area2D

class_name InteractionBox

signal hero_interact(hero)

func _ready():
	SceneManager.connect("player_interact", self, "_on_hero_interact")

func _on_hero_interact(hero: Player):
	if overlaps_body(hero):
		print("hero interact")
		emit_signal("hero_interact", hero)
