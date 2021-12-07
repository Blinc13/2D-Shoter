extends Enemy

class_name Spider

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_to_target(speed*delta)
