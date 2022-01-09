extends Bullet

func _physics_process(delta):
	bullet_update(delta)
	update_damp()


func collide(body_rid, body, body_shape_index, local_shape_index):
	queue_free()
