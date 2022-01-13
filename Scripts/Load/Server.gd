extends Node

var Port:int=GlobalVariables.gameSetUp["Server"]["Port"]
var MaxPlayers:int=GlobalVariables.gameSetUp["Server"]["MaxPlayers"]
var Ip:String=GlobalVariables.gameSetUp["Server"]["Ip"]
var Net=NetworkedMultiplayerENet.new()

var isServer:bool=false

signal Connected
signal Disconnected

func _init():
	set_process(false)

func StartServer():
	Net.create_server(Port,MaxPlayers)
	
	get_tree().set_network_peer(Net)
	
	Net.connect("peer_connected",self,"_player_connected")
	Net.connect("peer_disconnected",self,"_player_disconnected")
	
	isServer=true
	
	print("ServerInit")

func StartClient():
	Net.create_client(Ip,Port)
	
	get_tree().set_network_peer(Net)
	
	print("ClientInit")


func _player_connected(id):
	print("Player connected: ",id)

func _player_disconnected(id):
	print("Player disconnected: ",id)
	
	get_node("/root/Level/PlayerNetworkController/"+str(id)).queue_free()

remotesync func start():
	get_node("/root").add_child(load("res://Scenes/Levels/BetaLevel.tscn").instance())

func start_game():
	get_tree().set_refuse_new_network_connections(true)
	rpc("start")
	
	for i in get_tree().get_network_connected_peers():
		get_node("/root/Level").spawn_player(i)
	
	var net=get_node("/root/Level/PlayerNetworkController")
	
	net.rpc("init",net.GetPlayersList())
