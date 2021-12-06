extends CanvasLayer

var hero

func init(node):
	hero=node

func _process(delta):
	$Label.text=str(hero.health)
	$AnimatedSprite.position=get_viewport().get_mouse_position()
	$AnimatedSprite.frame=hero.weapon.reload/hero.weapon.relTime*5
