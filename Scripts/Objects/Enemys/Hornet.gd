extends Enemy


func _process(delta):
	move_to_target(speed*delta)
	attack()
