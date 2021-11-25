extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity: Vector2
const speed=200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Up"):
		velocity.y-=speed
	if Input.is_action_pressed("Down"):
		velocity.y+=speed
	if Input.is_action_pressed("Left"):
		velocity.x-=speed
		$AnimatedSprite.flip_h=true
	if Input.is_action_pressed("Right"):
		velocity.x+=speed
		$AnimatedSprite.flip_h=false
	
	move_and_slide(velocity)
	velocity=Vector2()
	
	print_debug(delta)
