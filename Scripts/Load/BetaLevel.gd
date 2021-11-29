extends Node2D

func _ready():
	var node=preload("res://Scenes/Another/Hero.tscn").instance()
	var nod=preload("res://Scenes/Another/GameUi.tscn").instance()
	nod.init(node)
	add_child(node)
	node.add_child(nod)
	node.position=Vector2(50,0)
	add_child(preload("res://Scenes/Another/Enemy.tscn").instance())
