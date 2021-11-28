extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var path_pos:int
var path:    PoolVector2Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("../Line2D").points=get_node("../Nav").get_simple_path(position,get_node("../Hero").position)
