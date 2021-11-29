extends KinematicBody2D

class_name Hero

var Bullet=preload("res://Scenes/Weapons/Bullet.tscn")

export(float) var speed=150
export(float) var relTime=0.3
export(float) var health=100

var velocity: Vector2
var firePos: Vector2
var reload=relTime

func _input(event):
	if event is InputEventMouseMotion:
		firePos=get_local_mouse_position().normalized()

func _process(delta:float):
	var dash=Input.is_action_pressed("Dash")
	velocity=Vector2()
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
		var node=Bullet.instance()
		node.start(firePos,position+firePos*10)
		get_parent().add_child(node)
	
	if velocity.length() == 0:
		$AnimatedSprite.playing=false
	else:
		$AnimatedSprite.playing=true
	
	move_and_slide(velocity.normalized()*(speed+500*int(dash)))
	reload+=delta

func _on_Area2D_body_entered(body:Bullet):
	if body==null:
		return
	health-=body.damage(velocity)
	body.queue_free()
