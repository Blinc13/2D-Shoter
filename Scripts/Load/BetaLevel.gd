extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var node=preload("res://Scenes/Another/Hero.tscn").instance()
	var nod=preload("res://Scenes/Another/GameUi.tscn").instance()
	nod.init(node)
	add_child(node)
	node.add_child(nod)
	add_child(preload("res://Scenes/Another/Enemy.tscn").instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
