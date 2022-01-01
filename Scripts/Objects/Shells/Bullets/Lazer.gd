extends Bullet

func _physics_process(delta):
	bullet_update(delta)

func collide(body_rid, body, body_shape_index, local_shape_index):
	destroy()
	queue_free()
