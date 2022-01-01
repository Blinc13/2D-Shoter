extends Enemy

var lazer=preload("res://Scenes/Weapons/Shells/Lazer.tscn")
var shoots:bool=false
onready var ray:RayCast2D=$RayCast2D

func _ready():
	ray.add_exception(target)

func _process(delta):
	move_to_target(speed*delta)

func _on_AttackTimer_timeout():
	if shoots:
		var node=lazer.instance()
		var vec=global_position.direction_to(target.position)
		node.start(vec,global_position+vec*20)
		get_node("/root/Level").add_child(node)


func _on_DirCheck_timeout():	
	ray.set_cast_to(target.position-global_position)
	
	var check=ray.get_collider() != null or global_position.distance_to(target.position)>100
	set_process(check)
	shoots=!check

func death():
	$DirCheck.stop()
	$AttackTimer.stop()
	$PathTimerUpdate.stop()
