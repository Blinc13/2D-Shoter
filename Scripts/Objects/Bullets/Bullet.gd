extends RigidBody2D

class_name Bullet

export(float) var speed=300
export(float) var damage=0.2
export(float) var dfactor=0.5

func start(point:Vector2,pos:Vector2):
	linear_velocity=point*speed
	position=pos
	rotate(point.angle())
	$Sprite.playing=true

func bullet_update(delta):
	set_linear_damp(speed*dfactor / linear_velocity.length())
	if linear_velocity.length()<3:
		$Sprite.play("Destroy")
		$DestroyTimer.start(0.18)
		set_physics_process(false)

func damage(vel:Vector2):
	return int(damage*(linear_velocity-vel).length()/2)

func _on_Timer_timeout():
	queue_free()

func Ricochet_beg(body_rid, body, body_shape_index, local_shape_index):
	$Particles.amount=linear_velocity.length()/10
	$Particles.global_rotation=Physics2DServer.body_get_direct_state(get_rid()).get_contact_local_normal(0).angle()
	$Particles.restart()

func Ricochet_end(body_rid, body, body_shape_index, local_shape_index):
	$Particles.emitting=false