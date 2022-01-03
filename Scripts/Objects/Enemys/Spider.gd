extends Enemy

class_name Spider

func _process(delta):
	move_to_target(speed*delta)
	attack()
