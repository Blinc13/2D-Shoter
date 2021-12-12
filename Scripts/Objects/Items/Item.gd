extends Sprite

class_name Item

export(float) var relTime=10

signal used

func use_item(obj):
	pass

func Activated(obj):
	use_item(obj)
	$Area2D.set_deferred("monitoring",false)
	$Timer.start(relTime)
	emit_signal("used")

func _on_Timer_timeout():
	$Area2D.set_deferred("monitoring",true)
