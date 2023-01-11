extends Node

var xp = 0

onready var skill_tree: SkillTree = $SkillTree

func _ready():
	GameEvents.connect("enemy_dies", self, "on_enemy_dies")

func on_enemy_dies(enemy: Enemy):
	xp += enemy.stats.xp_value
	print(xp)

func get_spell(name: String) -> Skill:
	return skill_tree.get_skill(name)
