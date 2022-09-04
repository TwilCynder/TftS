extends InteractionBox

class_name LookInteractionBox

func _on_hero_interact(hero: Player):
	if hero.is_looking_towards(self.position):
		._on_hero_interact(hero)
