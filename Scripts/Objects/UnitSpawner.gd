extends Node2D

export(float)       var Delay=20.0
export(int)         var MaxUnits=10
export(PackedScene) var UnitScene

var time: float
var units:Array

signal unit_spawned(body)

func reinit(node:PackedScene,timeInterval):
	UnitScene=node
	Delay=timeInterval

func _process(delta):
	time+=delta
	
	print(units.size())
	
	if time>Delay and units.size()<MaxUnits:
		units.append(UnitScene.instance())
		get_parent().add_child(units.back())
		time=0
