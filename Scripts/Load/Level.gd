extends Node2D
class_name Level

export(PoolVector2Array) var SpawnPoints=[Vector2(0,0)]
export(NodePath) var PlayerControllNode="."

var DeadHero
var Respawn:bool=true
var Player=preload("res://Scenes/Another/HeroTemplate.tscn")
var RespTime=GlobalVariables.gameSetUp["Game"]["PlayerRespTime"]

func _ready():
	get_node("PlayerNetworkController/1").name=str(get_tree().get_network_unique_id())

func _on_Hero_Dead(hero):
	if Respawn:
		DeadHero=hero
		$DeadTimer.start(RespTime)

func resp():
	DeadHero.position=SpawnPoints[randi()%SpawnPoints.size()]
	DeadHero._ready()
	$DeadTimer.stop()

remotesync func spawn_player(name:int):
	var node=Player.instance()
	node.set_network_master(name)
	
	node.name=str(name)
	$PlayerNetworkController.add_child(node)
