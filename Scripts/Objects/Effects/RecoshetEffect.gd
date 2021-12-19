extends Particles2D

func _ready():
	print(amount)

func start(pos:Vector2,dir:Vector2,am:int):
	amount=am
	rotation=dir.angle()
	global_position=pos
	emitting=true
	$DestroyTimer.start(lifetime+0.4)
