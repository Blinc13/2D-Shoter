extends Particles2D

export(float) var Wait:float=0.4

func _ready():
	emitting=true
	$Timer.start(lifetime+Wait)

func start(pos:Vector2,dir:Vector2,am:int=amount):
	amount=am
	rotation=dir.angle()
	global_position=pos
