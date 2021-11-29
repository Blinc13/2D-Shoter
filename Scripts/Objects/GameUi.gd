extends CanvasLayer

var hero

func init(node):
	hero=node

func _process(delta):
	$Label.text=str(hero.health)
