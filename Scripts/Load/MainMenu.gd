extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	visible=false
	get_tree().root.add_child(load("res://Scenes/Levels/BetaLevel.tscn").instance())
	print(SIZE_EXPAND)
