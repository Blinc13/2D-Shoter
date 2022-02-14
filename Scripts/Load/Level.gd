extends Node2D
class_name Level

export(PoolVector2Array) var SpawnPoints=[Vector2(0,0)]
export(NodePath) var PlayerControllNode="."

var DeadHero
var CanRespawn:bool=true
var RespawnTimeOut:bool=false
var Player=preload("res://Scenes/Another/HeroTemplate.tscn")
var RespTime=GlobalVariables.gameSetUp["Game"]["PlayerRespTime"]

func _ready():
	Events.connect("resp",self,"resp")

#Slots
func _on_Hero_Dead(hero):
	DeadHero=hero
	$DeadTimer.start(RespTime)

func RespTimeOut():
	RespawnTimeOut=true

func resp():
	if RespawnTimeOut and CanRespawn:
		DeadHero.position=SpawnPoints[randi()%SpawnPoints.size()]
		DeadHero._ready()
		$DeadTimer.stop()
		
		RespawnTimeOut=false
#Remote funcs
remotesync func spawn_player(name:int):
	var node=Player.instance()
	node.set_network_master(name)
	
	node.name=str(name)
	get_node(PlayerControllNode).add_child(node)

func _exit_tree():
	for i in get_children():
		i.free()
