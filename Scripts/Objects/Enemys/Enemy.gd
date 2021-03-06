extends KinematicBody2D

class_name Enemy

export(float) var health=100
export(float) var attack_radius=4
export(float) var speed=50
export(float) var damag=20
export(float) var dead_visible_time=10

onready var nav=$"/root/Level/Nav"
var target:Node2D

onready var AnimationObj:AnimatedSprite=$AnimatedSprite
onready var TimerObj:Timer=$Timer
onready var Hitbox:Area2D=$Hitbox

var pos:int
var attacking:bool
var death:bool
var path:    PoolVector2Array

func _ready():
	attack_radius+=14
	set_process(false)

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
		
		AnimationObj.playing=false
		AnimationObj.frame=rand_range(0,AnimationObj.frames.get_frame_count("death"))
		
		Hitbox.set_deferred("monitoring",false)
		set_collision_layer_bit(0,false)
		
		set_process(false)
		death=true
		death()


func HitboxAct(body:Bullet):
	if body==null:return #Надо чтобы не вылетало при дебагере
	
	damage(body.damage(Vector2(0,0)))
	body.queue_free()

func _on_AnimatedSprite_animation_finished():
	if attacking and !death:
		attacking=false
		AnimationObj.play("run")
		set_process(true)
		
		if global_position.distance_to(target.position)<=attack_radius:
			target.damage(damag)
			if target.health<1:
				print("Defeat!")
				TargetDead()

func TriggerAct(node:Node2D):
	if node.is_in_group("Hero") && node.health>0:
		target=node
		$Trigger.set_deferred("monitoring",false)
		AnimationObj.playing=true
		init()
		set_process(true)

func TargetDead():
	$Trigger.set_deferred("monitoring",true)
	AnimationObj.playing=false
	death()
	set_process(false)

func init():
	pass

func death():
	pass
