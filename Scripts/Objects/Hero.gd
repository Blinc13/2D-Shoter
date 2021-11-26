extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const speed=200
const relTime=0.1
var velocity: Vector2
var firePos: Vector2
var reload=relTime

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event is InputEventMouseMotion:
		firePos=get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Up"):
		velocity.y-=1
	if Input.is_action_pressed("Down"):
		velocity.y+=1
	if Input.is_action_pressed("Left"):
		velocity.x-=1
		$AnimatedSprite.flip_h=true
	if Input.is_action_pressed("Right"):
		velocity.x+=1
		$AnimatedSprite.flip_h=false
	
	if Input.is_action_pressed("Fire") and reload>=relTime:
		reload=0
		print_debug("А ну заткнись, этого нет, бюджет - 1 пачка дошика")
	
	if velocity.length() == 0:
		$AnimatedSprite.playing=false
	else:
		$AnimatedSprite.playing=true
	
	move_and_slide(velocity.normalized()*speed)
	velocity=Vector2()
	reload+=delta
	
	#print_debug(delta)
