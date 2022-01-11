extends Node

var Port:int=GlobalVariables.gameSetUp["Server"]["Port"]
var MaxPlayers:int=GlobalVariables.gameSetUp["Server"]["MaxPlayers"]
var Ip:String="192.168.0.103"
var Net=NetworkedMultiplayerENet.new()

func _init():
	set_process(false)

func StartServer():
	Net.create_server(Port,MaxPlayers)
	
	get_tree().set_network_peer(Net)
	
	Net.connect("peer_connected",self,"_player_connected")
	Net.connect("peer_disconnected",self,"_player_disconnected")
	
	print("ServerInit")

func StartClient():
	Net.create_client(Ip,Port)
	
	get_tree().set_network_peer(Net)
	
	print("ClientInit")


func _player_connected(id):
	print("Player connected: ",id)
	
	var Network=get_node("/root/Level/PlayerNetworkController")
	
	Network.rpc_id(id,"init",Network.GetPlayersList())
	
	get_node("/root/Level").rpc("spawn_player",id)

func _player_disconnected(id):
	print("Player disconnected: ",id)
	get_node("/root/Level/PlayerNetworkController/"+str(id)).queue_free()
