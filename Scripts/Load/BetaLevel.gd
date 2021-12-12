extends Node2D

func _ready():
	pass


func _on_Hero_Dead():
	get_tree().quit(0)


func _on_CrocogunItem_used():
	print("item used")
