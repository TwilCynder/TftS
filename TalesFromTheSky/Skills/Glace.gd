extends Skill

var IceEffect: Resource = load("res://Skills/Effects/Ice/IceEffect.tscn")
var IceBlock: Resource = load("res://Skills/Effects/Ice/IceBlock.tscn")

func _ready():
	print("Ice ready !")
		
func display_effect(player: Player):
	var position: Vector2 = player.direction.normalized() * 16
	var effect = player.effect_manager.add_effect(IceEffect, position)
	effect.connect("effect_end", self, "_on_effect_finished", [player])
		
func use(player: Player):
	print("Ice used !")
	display_effect(player)
	
func _on_effect_finished(player: Player):
	var block = IceBlock.instance()
	player.end_skill()
