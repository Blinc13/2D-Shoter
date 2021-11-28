extends KinematicBody2D

var path_pos:int
var path:    PoolVector2Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../Line2D".points=$"../Nav".get_simple_path(position,$"../Hero".position)


func _on_Area2D_body_entered(body:Bullet):
	print("Павуку пизда: "+str(body.damage()))
