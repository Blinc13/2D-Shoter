extends KinematicBody2D

onready var DrawingObj=$Drawing
onready var WeaponsList=$Drawing/Weapons
var WeaponIndex=0

remote func set_position(pos:Vector2):
	position=pos

remote func set_rotation(angle:float):
	DrawingObj.rotation=angle

remote func ch_weapon():
	WeaponsList.get_child(WeaponIndex).visible=false
	WeaponIndex+=1
	
	if WeaponIndex > WeaponsList.get_child_count()-1:
		WeaponIndex=0
	
	WeaponsList.get_child(WeaponIndex).visible=true
