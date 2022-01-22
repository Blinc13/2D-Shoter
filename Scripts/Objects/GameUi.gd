extends CanvasLayer

onready var HealthBar=$Control/HBoxContainer/HBoxContainer/VBoxContainer/ProgressBar
onready var WeaponIcon=$Control/HBoxContainer/WeaponIcon
onready var Aim=$AnimatedSprite

var weapon:Weapon
var hero:Hero

func _init():
	set_process(false)

func _ready():
	Events.connect("update",self,"GameEnd")

func init(Hero):
	hero=Hero
	WeaponChanged(Hero.weapon)
	
	HealthBar.max_value=hero.maxHealth
	HealthBar.value=hero.health
	
	$Control.visible=true
	$VBoxContainer/VBoxContainer2.visible=false
	
	set_process(true)

func _input(event):
	if event is InputEventMouseMotion:
		Aim.position=get_viewport().get_mouse_position()

func _process(delta):
	Aim.frame=weapon.rel/weapon.relTime*5

func HeroDead(hero):
	$Control.visible=false
	$VBoxContainer/VBoxContainer2.visible=true

func HealthChanged(value):
	HealthBar.value=value

func WeaponChanged(NewWeapon):
	weapon=NewWeapon
	WeaponIcon.texture=weapon.uiIcon

func GameEnd(text:String):
	$VBoxContainer/VBoxContainer.visible=true

func ExitButtonPressed():
	Server.end_game()
