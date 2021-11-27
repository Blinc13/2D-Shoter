extends RigidBody2D

export(float) var windage

const speed=200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start(point:Vector2,pos:Vector2):
	linear_velocity=point*speed
	position=pos
	rotate(point.angle())
	$AnimatedSprite.playing=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	linear_velocity-=linear_velocity*windage
