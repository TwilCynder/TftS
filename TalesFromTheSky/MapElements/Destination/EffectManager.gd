extends YSort

class_name EffectManager

func add_effect(fx, position) -> AnimatedEffect:
	return add_effect_to(self, fx, position)
	
static func add_effect_to(node: Node2D, fx, position) -> AnimatedEffect:
	var effect = fx.instance()
	
	assert(effect is AnimatedEffect, "Instanciated effect was not a AnimatedEffect node")
	
	node.add_child(effect)
	if position != null:
		effect.position = position
	return effect
