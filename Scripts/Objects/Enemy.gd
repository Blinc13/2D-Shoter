extends KinematicBody2D

export(float) var health=100
export(float) var attack_radius=4
export(float) var speed=50
export(float) var damage=20

var pos:int
var path:    PoolVector2Array

func _process(delta):
	var distance=speed*delta
	if pos==path.size():
		path=$"../Nav".get_simple_path(position,$"../Hero".position)
		pos=1
	elif position.distance_to(path[pos])<2:
		pos+=1
	else:
		var new_pos=position.linear_interpolate(path[pos],distance/position.distance_to(path[pos]))
		if new_pos.x<position.x:
			$AnimatedSprite.flip_h=true
		else:
			$AnimatedSprite.flip_h=false
		position=new_pos
	if position.distance_to($"../Hero".position)<14+attack_radius:
		$AnimatedSprite.play("attack")
	else:
		$AnimatedSprite.play("run")

func _on_Area2D_body_entered(body:Bullet):
	if body==null:
		return
	health-=body.damage(Vector2(0,0))
	print(health)
	#if health<=0:
	#	$AnimatedSprite.play("death")
	#	$AnimatedSprite.update()
	body.free()
