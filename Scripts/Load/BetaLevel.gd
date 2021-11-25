extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var node=preload("res://Scenes/Another/Hero.tscn").instance()
	add_child(node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
