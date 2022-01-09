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


remotesync func spawn_player(name:int):
	if get_tree().get_network_unique_id() == name:
		return
	
	var node=Player.instance()
	node.set_network_master(name)
	
	node.name=str(name)
	$PlayerNetworkController.add_child(node)
