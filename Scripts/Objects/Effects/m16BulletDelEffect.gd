extends Particles2D

func start(pos:Vector2):
	position=pos
	emitting=true
	$Timer.start(lifetime)
