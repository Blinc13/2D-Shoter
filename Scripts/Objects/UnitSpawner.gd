extends Node2D

export(float)       var Delay=20.0
export(int)         var MaxUnits=10
export(PackedScene) var UnitScene

var time: float

signal unit_spawned(body)

func reinit(node:PackedScene,timeInterval):
	UnitScene=node
	Delay=timeInterval

func _process(delta):
	time+=delta
	
	if time>Delay and get_child_count()<MaxUnits:
		var unit=UnitScene.instance()
		add_child(unit)
		emit_signal("unit_spawned",unit)
		time=0
