extends Node

var Port:int=GlobalVariables.gameSetUp["Server"]["Port"]
var MaxPlayers:int=GlobalVariables.gameSetUp["Server"]["MaxPlayers"]
var Ip:String="192.168.0.103"
var Net=NetworkedMultiplayerENet.new()

var PlayerStateCol={}
var Ids:Array

func _init():
	set_process(false)

func StartServer():
	Net.create_server(Port,MaxPlayers)
	
	get_tree().set_network_peer(Net)
	
	Net.connect("peer_connected",self,"_player_connected")
	Net.connect("peer_disconnected",self,"_player_disconnected")
	
	set_process(true)
	
	print("ServerInit")

func StartClient():
	Net.create_client(Ip,Port)
	
	get_tree().set_network_peer(Net)
	
	Net.connect("connection_succeeded",self,"_connected")
	Net.connect("connection_failed",self,"_connectionF")
	
	_connected()
	
	print("ClientInit")


func _player_connected(id):
	print("Player connected: ",id)
	
	Ids.append(id)
func _player_disconnected(id):
	print("Player disconnected: ",id)
	
	Ids.erase(id)
	get_node("/root/Level/PlayerNetworkController/"+str(id)).queue_free()


func _connected():
	get_node("/root/Level/1").name=str(get_tree().get_network_unique_id())
	print("connected")
func _connectionF():
	pass


func _process(delta):
	ReturnPosition()


func SendPosition(pos:Vector2):
	if get_tree().get_network_unique_id()==1:
		return
	rpc_unreliable_id(1,"SetState",pos)

remote func SetState(pos:Vector2):
	var PlayerID=get_tree().get_rpc_sender_id()
	PlayerStateCol[PlayerID]=pos

remote func GetState():
	return PlayerStateCol

func ReturnPosition():
	var node=get_node_or_null("/root/Level/PlayerNetworkController")
	if node!=null:
		PlayerStateCol[1]=get_node("/root/Level/PlayerNetworkController/1").position
		node.rpc("_update",PlayerStateCol)
		node._update(PlayerStateCol)
