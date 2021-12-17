extends CanvasLayer

onready var HealthBar=$Control/HBoxContainer/HBoxContainer/VBoxContainer/ProgressBar
onready var WeaponIcon=$Control/HBoxContainer/WeaponIcon
onready var Aim=$AnimatedSprite

var weapon:Weapon
var hero:Hero

func _init():
	set_process(false)

func init(Hero):
	hero=Hero
	weapon=Hero.weapon
	
	HealthBar.max_value=hero.health
	HealthBar.value=hero.health
	
	set_process(true)

func _input(event):
	if event is InputEventMouseMotion:
		Aim.position=get_viewport().get_mouse_position()

func _process(delta):
	Aim.frame=weapon.rel/weapon.relTime*5

func HealthChanged(value):
	HealthBar.value=value

func WeaponChanged(NewWeapon):
	weapon=NewWeapon
	WeaponIcon.texture=weapon.uiIcon
