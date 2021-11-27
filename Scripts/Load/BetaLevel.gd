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
	
	$Line2D.points=$Nav.get_simple_path(node.position,Vector2(85,-100))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
