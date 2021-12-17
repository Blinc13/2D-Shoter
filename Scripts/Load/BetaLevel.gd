extends Node2D
class_name Level

export(float) var MexHeroHealth:float=100

func _on_Hero_Dead():
	get_tree().quit(0)

func _on_CrocogunItem_used():
	print("item used")
