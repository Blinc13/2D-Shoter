extends Node

var Port:int=GlobalVariables.gameSetUp["Server"]["Port"]
var MaxPlayers:int=GlobalVariables.gameSetUp["Server"]["MaxPlayers"]
var Ip:String=GlobalVariables.gameSetUp["Server"]["Ip"]
var Net:NetworkedMultiplayerENet

var isServer:bool=false

var Map:String="res://Scenes/Levels/BetaLevel.tscn"

signal Connected(id)
signal Disconnected(id)

func _init():
	set_process(false)

func StartServer():
	Net=NetworkedMultiplayerENet.new()
	Net.create_server(Port,MaxPlayers)
	
	get_tree().set_network_peer(Net)
	
	Net.connect("peer_connected",self,"_player_connected")
	Net.connect("peer_disconnected",self,"_player_disconnected")
	
	isServer=true
	
	print("ServerInit")

func StartClient():
	Net=NetworkedMultiplayerENet.new()
	Net.create_client(Ip,Port)
	
	get_tree().set_network_peer(Net)
	
	print("ClientInit")

func StopServer():
	Net=null
	get_tree().set_network_peer(null)
	
	GlobalVariables.open()

func _player_connected(id):
	rpc_id(id,"set_variables",GlobalVariables.gameSetUp["Game"])
	print("Player connected: ",id)
	
	rpc("send_signal","Connected",id)
func _player_disconnected(id):
	print("Player disconnected: ",id)
	
	rpc("send_signal","Disconnected",id)


remote func set_variables(gameSetUp):
	GlobalVariables.gameSetUp["Game"]=gameSetUp
remotesync func send_signal(name,arg):
	print("rpc signal")
	emit_signal(name,arg)

remotesync func start(map:String):
	get_node("/root").add_child(load(map).instance())
	get_node("/root/Control").visible=false
remotesync func end():
	get_node("/root/Level").queue_free()
	get_node("/root/Control").visible=true

func start_game():
	get_tree().set_refuse_new_network_connections(true)
	rpc("start",Map)
	
	for i in get_tree().get_network_connected_peers():
		get_node("/root/Level").spawn_player(i)
	
	var net=get_node("/root/Level/PlayerNetworkController")
	
	net.rpc("init",net.GetPlayersList())

func end_game():
	get_tree().set_refuse_new_network_connections(false)
	if isServer:
		rpc("end")
	else:
		end()
