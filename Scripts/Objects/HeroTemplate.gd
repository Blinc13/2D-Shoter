extends KinematicBody2D

onready var DrawingObj=$Drawing
onready var WeaponsList=$Drawing/Weapons
onready var LastWeapon:Weapon=WeaponsList.get_child(0)

remote func set_position(pos:Vector2):
	position=pos

remote func set_rotation(angle:float):
	DrawingObj.rotation=angle

remote func ch_weapon(Name:String):
	LastWeapon.visible=false
	LastWeapon=WeaponsList.get_node(Name)
	LastWeapon.visible=true

func damage(dam):
	pass


func bulletCollide(body:Bullet):
	body.queue_free()
