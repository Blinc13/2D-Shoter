extends Particles2D

export(float) var Wait=1

func _ready():
	emitting=true
	$Timer.start(lifetime+Wait)

func start(pos:Vector2):
	global_position=pos
