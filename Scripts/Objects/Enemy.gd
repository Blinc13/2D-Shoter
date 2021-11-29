extends KinematicBody2D

export(float) var health=100
export(float) var attack_radius=4
export(float) var speed=50
export(float) var damage=20
export(float) var dead_visible_time

var pos:int
var target
var attacking:bool
var death:bool
var path:    PoolVector2Array

func _ready():
	target=$"../Hero"
	attack_radius+=14

func _process(delta):
	if pos==path.size():
		path=$"../Nav".get_simple_path(position,target.position)
		pos=1
	elif position.distance_to(path[pos])<2:
		pos+=1
	else:
		var new_pos=position.linear_interpolate(path[pos],speed*delta/position.distance_to(path[pos]))
		$AnimatedSprite.flip_h=position.x>new_pos.x
		position=new_pos
		attack()

func attack():
	if position.distance_to(target.position)<attack_radius:
		$AnimatedSprite.play("attack")
		target.health-=damage
		attacking=true
		set_process(false)
	else:
		$AnimatedSprite.play("run")


func _on_Area2D_body_entered(body:Bullet):
	if body==null:return #Надо чтобы не вылетало при дебагере
	
	health-=body.damage(Vector2(0,0))
	
	if health<=0:
		$Timer.start(dead_visible_time)
		$AnimatedSprite.play("death")
		
		set_collision_layer_bit(0,false)
		$Area2D.set_collision_layer_bit(1,false)
		
		set_process(false)
		death=true
	body.queue_free()

func _on_AnimatedSprite_animation_finished():
	if attacking and !death:
		attacking=false
		set_process(true)


func _on_Timer_timeout():
	queue_free()
