extends Particles2D

func start(pos:Vector2):
	global_position=pos
	emitting=true
	$Timer.start(lifetime+0.4)
