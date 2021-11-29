extends KinematicBody2D

export(float) var health=100
export(float) var attack_radius=4
export(float) var speed=50
export(float) var damage=20

var pos:int
var target
var path:    PoolVector2Array

func _ready():
	target=$"../Hero"

func _process(delta):
	if pos==path.size():
		path=$"../Nav".get_simple_path(position,target.position)
		pos=1
	elif position.distance_to(path[pos])<2:
		pos+=1
	else:
		var new_pos=position.linear_interpolate(path[pos],speed*delta/position.distance_to(path[pos]))
		$AnimatedSprite.flip_h=bool(floor(new_pos.x-position.x))
		position=new_pos
	attack()
func attack():
	if position.distance_to(target.position)<14+attack_radius:
		$AnimatedSprite.play("attack")
		target.health-=damage
		set_process(false)
	else:
		$AnimatedSprite.play("run")

func _on_Area2D_body_entered(body:Bullet):
	if body==null:
		return
	health-=body.damage(Vector2(0,0))
	body.queue_free()


func _on_AnimatedSprite_animation_finished():
	set_process(true)
