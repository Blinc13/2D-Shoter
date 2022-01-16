extends Node2D
class_name Level

export(PoolVector2Array) var SpawnPoints=[Vector2(0,0)]
export(NodePath) var PlayerControllNode="."

var DeadHero
var Player=preload("res://Scenes/Another/HeroTemplate.tscn")

func _ready():
	get_node("PlayerNetworkController/1").name=str(get_tree().get_network_unique_id())

func _on_Hero_Dead(hero):
	DeadHero=hero
	$DeadTimer.start(1)

func resp():
	DeadHero._ready()
	DeadHero.position=SpawnPoints[randi()%SpawnPoints.size()]
	$DeadTimer.stop()

func _on_CrocogunItem_used():
	print("item used")

remotesync func spawn_player(name:int):
	var node=Player.instance()
	node.set_network_master(name)
	
	node.name=str(name)
	$PlayerNetworkController.add_child(node)
