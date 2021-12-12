extends CanvasLayer

export(NodePath) var HeroNodePath
var hero

func _ready():
	hero=get_node(HeroNodePath)

func _input(event):
	if event is InputEventMouseMotion:
		$AnimatedSprite.position=get_viewport().get_mouse_position()

func _process(delta):
	$AnimatedSprite.frame=hero.weapon.rel/hero.weapon.relTime*5

func HealthChanged(value):
	$Label.text=str(value)
