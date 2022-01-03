extends Particles2D

func _ready():
	emitting=true
	$Timer.start(lifetime+0.4)

func start(pos:Vector2,dir:Vector2,am:int=amount):
	amount=am
	rotation=dir.angle()
	global_position=pos
