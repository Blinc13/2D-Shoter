extends Node2D

class_name Item

export(float) var relTime=10

var reloaded=true


func use_item(obj):
	pass

func Activated(obj):
	if reloaded:
		use_item(obj)
		reloaded=false
		$Timer.start(relTime)

func _on_Timer_timeout():
	reloaded=true
