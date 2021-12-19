extends RigidBody2D

class_name Bullet

export(float) var speed=300
export(float) var damage=0.2
export(float) var dfactor=0.5

export(PackedScene) var ricochet_eff=preload("res://Scenes/Effects/RecoshetParticles.tscn")

func start(point:Vector2,pos:Vector2,spBost=1.0):
	speed*=spBost
	linear_velocity=point*(speed)
	position=pos
	rotation=point.angle()

func bullet_update(delta):
	if linear_velocity.length()<4:
		$Sprite.play("Destroy")
		set_physics_process(false)
	set_linear_damp(speed*dfactor / linear_velocity.length())

func damage(vel:Vector2):
	return int(damage*(linear_velocity-vel).length()/2)

func Ricochet_beg(body_rid, body, body_shape_index, local_shape_index):
	var node=ricochet_eff.instance()
	get_parent().add_child(node)
	node.start(global_position,Physics2DServer.body_get_direct_state(get_rid()).get_contact_local_normal(0),
	linear_velocity.length()/10)

func Ricochet_end(body_rid, body, body_shape_index, local_shape_index):
	pass
