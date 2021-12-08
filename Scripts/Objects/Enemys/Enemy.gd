extends KinematicBody2D

class_name Enemy

export(float) var health=100
export(float) var attack_radius=4
export(float) var speed=50
export(float) var damag=20
export(float) var dead_visible_time=10

var target
var nav

var pos:int
var attacking:bool
var death:bool
var path:    PoolVector2Array

func _ready():
	target=$"/root/Level/Hero"
	nav=$"/root/Level/Nav"
	attack_radius+=14

func move_to_target(distance):
	var pos_g=get_global_position()
	if pos==path.size():
		path=nav.get_simple_path(pos_g,target.position)
		pos=1
	elif pos_g.distance_to(path[pos])<2:
		pos+=1
	else:
		var new_pos=pos_g.linear_interpolate(path[pos],distance/pos_g.distance_to(path[pos]))
		$AnimatedSprite.flip_h=pos_g.x>new_pos.x
		set_global_position(new_pos)
		attack()

func attack():
	if global_position.distance_to(target.position)<attack_radius:
		$AnimatedSprite.play("attack")
		attacking=true
		set_process(false)

func damage(dam:float):
	health-=dam
	
	if health<=0:
		$Timer.start(dead_visible_time)
		$AnimatedSprite.play("death")
		
		$HitBox.set_deferred("monitoring",false)
		set_collision_layer_bit(0,false)
		
		set_process(false)
		death=true


func _on_Area2D_body_entered(body:Bullet):
	if body==null:return #Надо чтобы не вылетало при дебагере
	
	damage(body.damage(Vector2(0,0)))
	body.queue_free()

func _on_AnimatedSprite_animation_finished():
	if attacking and !death:
		attacking=false
		$AnimatedSprite.play("run")
		if global_position.distance_to(target.position)<=attack_radius:
			target.damage(damag)
		set_process(true)
