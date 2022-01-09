extends Node

var Port:int=GlobalVariables.gameSetUp["Server"]["Port"]
var MaxPlayers:int=GlobalVariables.gameSetUp["Server"]["MaxPlayers"]
var Ip:String="192.168.0.103"
var Net=NetworkedMultiplayerENet.new()

var PlayerStateCol={}

func _init():
	set_process(false)

func StartServer():
	Net.create_server(Port,MaxPlayers)
	
	get_tree().set_network_peer(Net)
	
	Net.connect("peer_connected",self,"_player_connected")
	Net.connect("peer_disconnected",self,"_player_disconnected")
	
	PlayerStateCol[1]=Dictionary()
	PlayerStateCol[1]["I"]=["m16"]
	PlayerStateCol[1]["W"]=["m16"]
	
	set_process(true)
	
	print("ServerInit")

func StartClient():
	Net.create_client(Ip,Port)
	
	get_tree().set_network_peer(Net)
	
	print("ClientInit")


func _player_connected(id):
	print("Player connected: ",id)
	PlayerStateCol[id]=Dictionary()
	PlayerStateCol[id]["I"]=["m16"]
	PlayerStateCol[id]["W"]=["m16"]
func _player_disconnected(id):
	print("Player disconnected: ",id)
	
	PlayerStateCol.erase(id)
	get_node("/root/Level/PlayerNetworkController/"+str(id)).queue_free()


func _process(delta):
	ReturnPosition()


func SendPlayerState(State:Dictionary):
	if get_tree().get_network_unique_id()==1:
		PlayerStateCol[1]["P"]=State["P"]
		PlayerStateCol[1]["A"]=State["A"]
		return
	rpc_unreliable_id(1,"SetState",State)

remote func SetState(State:Dictionary):
	var PlayerID=get_tree().get_rpc_sender_id()
	PlayerStateCol[PlayerID]["P"]=State["P"]
	PlayerStateCol[PlayerID]["A"]=State["A"]

remote func SetWeapon(name:String):
	var PlayerID=get_tree().get_rpc_sender_id()
	PlayerStateCol[PlayerID]["W"]=name

func SendInventoryState(weapon:String):
	if get_tree().get_network_unique_id()==1:
		PlayerStateCol[1]["I"].append(weapon)
		return
	rpc_id(1,"SetPlayerInv",weapon)

func SendWeapon(name:String):
	if get_tree().get_network_unique_id() == 1:
		PlayerStateCol[1]["W"]=name
		return
	rpc_id(1,"SetWeapon",name)

func SetPlayerInv(weapon:String):
	var PlayerID=get_tree().get_rpc_sender_id()
	PlayerStateCol[PlayerID]["I"].append(weapon)

func ReturnPosition():
	var node=get_node_or_null("/root/Level/PlayerNetworkController")
	if node!=null:
		node.rpc("_update",PlayerStateCol)
		node._update(PlayerStateCol)
