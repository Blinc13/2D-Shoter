extends Node2D

var enemy=preload("res://Scenes/Another/Enemy.tscn")
var time:float

func _ready():
	var node=preload("res://Scenes/Another/Hero.tscn").instance()
	var nod=preload("res://Scenes/Another/GameUi.tscn").instance()
	nod.init(node)
	add_child(node)
	node.add_child(nod)
	node.position=Vector2(50,0)
	add_child(enemy.instance())

func _process(delta):
	time+=delta
	if time>20:
		add_child(enemy.instance())
		time=0
