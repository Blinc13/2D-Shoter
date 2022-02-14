extends Enemy

func init():
	$PathUpdateTimer.start(2)

func death():
	$PathUpdateTimer.stop()

func _process(delta):
	move_to_target(speed*delta)
	attack()
