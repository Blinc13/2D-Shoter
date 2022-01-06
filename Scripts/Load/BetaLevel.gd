extends Node2D
class_name Level

export(float) var MexHeroHealth:float=100

var Player=preload("res://Scenes/Another/HeroTemplate.tscn")

func _ready():
	Server.StartServer()
	get_node("PlayerNetworkController/1").name=str(get_tree().get_network_unique_id())

func _on_Hero_Dead():
	get_tree().quit(0)

func _on_CrocogunItem_used():
	print("item used")


func spawn_player(name:String):
	var node=Player.instance()
	node.name=name
	$PlayerNetworkController.add_child(node)
