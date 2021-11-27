extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var node=preload("res://Scenes/Another/Hero.tscn").instance()
	var nod=preload("res://Scenes/Another/GameUi.tscn").instance()
	nod.init(node)
	#nod.set_size(get_viewport_rect().size)
	add_child(node)
	node.add_child(nod)
	#nod.set_position(Vector2(-get_viewport_rect().size.x/2,-get_viewport_rect().size.y/2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
