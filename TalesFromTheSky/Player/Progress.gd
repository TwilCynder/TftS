extends Node

var xp = 0

func _ready():
	GameEvents.connect("enemy_dies", self, "on_enemy_dies")

func on_enemy_dies(enemy: Enemy):
	xp += enemy.stats.xp_value
	print(xp)
