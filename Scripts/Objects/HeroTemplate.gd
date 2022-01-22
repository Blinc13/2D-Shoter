extends KinematicBody2D

var alive:bool=true

onready var DrawingObj=$Drawing
onready var WeaponsList=$Drawing/Weapons
onready var LastWeapon:Weapon=WeaponsList.get_child(0)

var Effects={
	false:preload("res://Scenes/Effects/HeroDead.tscn"),
	true:preload("res://Scenes/Effects/HeroSpawn.tscn")
}

remote func set_position(pos:Vector2):
	position=pos

remote func set_rotation(angle:float):
	DrawingObj.rotation=angle

remote func ch_weapon(Name:String):
	LastWeapon.visible=false
	LastWeapon=WeaponsList.get_node(Name)
	LastWeapon.visible=true

remote func ch_state(st:bool):
	visible=st
	alive=st
	
	var node=Effects[st].instance()
	node.start(position)
	
	get_node("/root/Level").add_child(node)

func damage(dam):
	pass

func bulletCollide(body:Bullet):
	body.queue_free()
