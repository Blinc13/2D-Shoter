extends KinematicBody2D

class_name Hero

var Grenade=preload("res://Scenes/Weapons/Shells/Grenade.tscn")

export(float) var movSpeed=150
export(float) var dsTime = 0.3
export(float) var dsRelTime = 1

var velocity: Vector2
var firePos: Vector2
var WeaponIndex:int
var ChReload:float
var dsReload:float
var dash:float
var health:float=GlobalVariables.gameSetUp["Game"]["MaxPlayerHealth"]
var speed:float=movSpeed*GlobalVariables.gameSetUp["Game"]["PlayerSpeedCof"]

onready var WeaponsList=$Drawing/Weapons
onready var weapon=WeaponsList.get_child(0)
onready var DrawingObj=$Drawing
onready var AnimationObj=$Drawing/AnimatedSprite
onready var Cam=$Camera2D

signal HealthChanged(value)
signal Dead()
signal WeaponChanged(obj)
signal AmmoChanged(value)
signal HeroInit(Hero)

func _ready():
	speed*=GlobalVariables.gameSetUp["Game"]["PlayerSpeedCof"]
	emit_signal("HeroInit",self)

func _input(event):
	if event is InputEventMouseMotion:
		firePos=get_local_mouse_position().normalized()
	if event is InputEventJoypadMotion:
		if event.axis==JOY_AXIS_2:
			firePos.x=event.axis_value
		elif event.axis==JOY_AXIS_3:
			firePos.y=event.axis_value
		firePos=firePos.normalized()
	Cam.offset_h=firePos.x/3
	Cam.offset_v=firePos.y/3
	DrawingObj.rotation=firePos.angle()

func _process(delta:float):
	dsReload+=delta
	ChReload+=delta
	velocity=Input.get_vector("Left","Right","Up","Down")
	
	if Input.is_action_pressed("Fire") and weapon.reloaded:
		weapon.fire(firePos,position+firePos*10)
	
	if Input.is_action_pressed("Grenade") and weapon.altReloaded:
		weapon.altFire(firePos,position+firePos*10)
	
	if Input.is_action_pressed("ChWeapon") and ChReload>0.5:
		changeWeapon()
	
	AnimationObj.playing=velocity.x!=0
	move_and_slide(velocity*speed*(1+dash))
	move_and_slide(firePos*speed*dash)
	dash()

func dash():
	if Input.is_action_pressed("Dash") and dsReload >= dsRelTime:
		dash = 10
		$Timer.start(dsTime)
		dsReload = 0 

func changeWeapon():
	WeaponIndex+=1
	ChReload=0
	weapon.visible=false
	if WeaponIndex>=WeaponsList.get_child_count():
		WeaponIndex=0
	weapon=WeaponsList.get_child(WeaponIndex)
	weapon.visible=true
	emit_signal("WeaponChanged",weapon)

func _on_Timer_timeout():
	dash = 0

func damage(dam:float):
	health-=dam
	emit_signal("HealthChanged",health)
	
	if health<1:
		emit_signal("Dead")
		set_process(false)

func _on_Area2D_body_entered(body:Bullet):
	if body==null:return
	
	damage(body.damage(velocity*speed))
	body.queue_free()
