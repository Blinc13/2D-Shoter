extends KinematicBody2D

class_name Enemy

export(float) var health=100
export(float) var attack_radius=4
export(float) var speed=50
export(float) var damag=20
export(float) var dead_visible_time=10

onready var target=$"/root/Level/Hero"
onready var nav=$"/root/Level/Nav"

onready var AnimationObj=$AnimatedSprite
onready var TimerObj=$Timer
onready var Hitbox=$Hitbox

var pos:int
var attacking:bool
var death:bool
var path:    PoolVector2Array

func _ready():
	attack_radius+=14

func move_to_target(distance):
	var pos_g=get_global_position()
	if pos==path.size():
		new_path()
	elif pos_g.distance_to(path[pos])<2:
		pos+=1
	else:
		var new_pos=pos_g.linear_interpolate(path[pos],distance/pos_g.distance_to(path[pos]))
		AnimationObj.flip_h=pos_g.x>new_pos.x
		set_global_position(new_pos)
		attack()

func new_path():
	path=nav.get_simple_path(get_global_position(),target.position)
	pos=1

func attack():
	if global_position.distance_to(target.position)<attack_radius:
		AnimationObj.play("attack")
		attacking=true
		set_process(false)

func damage(dam:float):
	health-=dam
	
	if health<=0:
		TimerObj.start(dead_visible_time)
		AnimationObj.play("death")
		
		Hitbox.set_deferred("monitoring",false)
		set_collision_layer_bit(0,false)
		
		set_process(false)
		death=true


func HitboxAct(body:Bullet):
	if body==null:return #Надо чтобы не вылетало при дебагере
	
	damage(body.damage(Vector2(0,0)))
	body.queue_free()

func _on_AnimatedSprite_animation_finished():
	if attacking and !death:
		attacking=false
		AnimationObj.play("run")
		if global_position.distance_to(target.position)<=attack_radius:
			target.damage(damag)
		set_process(true)
