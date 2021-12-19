extends RigidBody2D
class_name Rocket

export(float) var Speed:float=500
export(float) var Acceleration:float=5
export(PackedScene) var ExplEffect

onready var acVec:Vector2
onready var expl=ExplEffect.instance()

func start(vel:Vector2,pos:Vector2,boost:float=1):
	acVec=vel*(Acceleration*boost)
	rotation=vel.angle()
	linear_velocity=acVec
	global_position=pos

func explosion():
	pass

func _integrate_forces(state):
	if linear_velocity.length()<Speed:
		apply_central_impulse(acVec)

func Contact(body_rid, body, body_shape_index, local_shape_index):
	expl.start(global_position)
	get_parent().add_child(expl)
	explosion()
	queue_free()
