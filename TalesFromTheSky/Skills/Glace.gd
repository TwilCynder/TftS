extends Skill

var IceEffect: Resource = load("res://Skills/Effects/Ice/IceEffect.tscn")
var IceBlock: Resource = load("res://Skills/Effects/Ice/IceBlock.tscn")

func _ready():
	print("Ice ready !")
		
func display_effect(player: Player, position: Vector2):
	var effect = player.add_effect_to_parent(IceEffect, position)
	effect.connect("effect_end", self, "_on_effect_finished", [player, position])
		
func use(player: Player):
	print("Ice used !")
	var position: Vector2 = player.direction.normalized() * 16
	player.instance_on_parent(IceBlock, position)
	display_effect(player, position)
	
	
func _on_effect_finished(player: Player, position: Vector2):
	player.end_skill()
