extends KinematicBody2D

class_name Hero

var Grenade=preload("res://Scenes/Weapons/Shells/Grenade.tscn")

export(float) var speed=150
export(float) var health=100
export(float) var dsTime = 0.3
export(float) var dsRelTime = 1

var velocity: Vector2
var firePos: Vector2
onready var weapon=$Weapons/Weapon
var dsReload = 0
var dash = 0

func _ready():
	$SoundPlayer.volume_db=GlobalVariables.variables["Sounds"]

func _input(event):
	if event is InputEventMouseMotion:
		firePos=get_local_mouse_position().normalized()
	if event is InputEventJoypadMotion:
		if event.axis==JOY_AXIS_2:
			firePos.x=event.axis_value
		elif event.axis==JOY_AXIS_3:
			firePos.y=event.axis_value
		firePos=firePos.normalized()

func _process(delta:float):
	dsReload+=delta
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
	
	if Input.is_action_pressed("Fire") and weapon.reloaded:
		$SoundPlayer.play(0)
		weapon.fire(firePos,position+firePos*10)
	
	if Input.is_action_pressed("Grenade") and weapon.reloaded:
		var node=Grenade.instance()
		node.start(firePos,position+firePos*10)
		get_parent().add_child(node)
	
	$AnimatedSprite.playing=velocity.x!=0
	
	move_and_slide(velocity.normalized()*speed*(1+dash))
	dash()

func dash():
	if Input.is_action_pressed("Dash") and dsReload >= dsRelTime:
		dash = 10
		$Timer.start(dsTime)
		dsReload = 0 

func _on_Timer_timeout():
	dash = 0

func damage(dam:float):
	health-=dam
	
	if health<1:
		set_process(false)

func _on_Area2D_body_entered(body:Bullet):
	if body==null:return
	
	damage(body.damage(velocity*speed))
	body.queue_free()