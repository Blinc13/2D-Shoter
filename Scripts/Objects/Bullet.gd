extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start(vel:Vector2,pos:Vector2):
	apply_central_impulse(vel)
	position=pos
	rotate(vel.angle())
	$AnimatedSprite.playing=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
