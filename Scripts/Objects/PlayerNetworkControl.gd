extends Node

class_name PlayerNetworkController
onready var PlayerNode=get_node("1")
onready var DrawingObj=PlayerNode.get_node("Drawing")

var PlayerTemplate=preload("res://Scenes/Another/HeroTemplate.tscn")

var Weapons={
	"m16":load("res://Scenes/Weapons/Guns/m16.tscn"),
	"Crocogun":load("res://Scenes/Weapons/Guns/Crocogun.tscn"),
	"RocketLauncher":load("res://Scenes/Weapons/Guns/RocketLauncher.tscn"),
	"Pistol":load("res://Scenes/Weapons/Guns/Pistol.tscn")
}

func _init():
	Server.connect("Disconnected",self,"Disconnected")

remote func init(List:Dictionary):
	print_debug("Init !: ",List)
	
	get_child(0).name=str(get_tree().get_network_unique_id())
	
	for i in List.keys():
		if int(i) == get_tree().get_network_unique_id():
			continue
		var node=PlayerTemplate.instance()
		
		node.name=i
		node.position=List[i]["P"]
		
		add_child(node)
		
		node.DrawingObj.rotation=List[i]["A"]

#					Data send
func _process(delta):
	PlayerNode.rpc_unreliable("set_position",PlayerNode.position)
	PlayerNode.rpc_unreliable("set_rotation",PlayerNode.DrawingObj.rotation)

#					Slots
func PlayerFire(name:String,vec:Vector2, pos:Vector2):
	PlayerNode.weapon.rpc(name,vec,pos)
func PlayerInventoryChanged(WeaponName):
	rpc("AddWeaponToPlayerInventory",WeaponName)
func PlayerWeaponChanged(weapon):
	PlayerNode.rpc("ch_weapon",weapon.name)
func PlayerSpawn(player):
	if PlayerNode == null:
		return
	PlayerNode.rpc("ch_state",true)
func PlayerDead(player):
	if PlayerNode == null:
		return
	PlayerNode.rpc("ch_state",false)
func Disconnected(id):
	rpc("PlayerDisconnected",id)
#					Slots remote
remote func AddWeaponToPlayerInventory(name:String):
	var PlayerID=get_tree().get_rpc_sender_id()
	print(name)
	get_node(str(PlayerID)).WeaponsList.add_child(Weapons[name].instance())

remotesync func PlayerDisconnected(id:int):
	get_node(str(id)).queue_free()

#					Server funcs
func GetPlayersList()->Dictionary:
	var Players:Dictionary
	
	for Player in get_children():
		var PlayerState:Dictionary
		
		PlayerState["P"]=Player.position
		PlayerState["A"]=Player.DrawingObj.rotation
		PlayerState["I"]=GetPlayerWeaponsNames(Player)
		
		Players[Player.name]=PlayerState
		
	return Players

func GetPlayerWeaponsNames(node)->Array:
	var inventory=node.WeaponsList.get_children()
	var inventoryNames:Array
	
	for i in inventory:
		inventoryNames.append(i.name)
	
	print_debug(inventoryNames)
	return inventoryNames

func GetAlivePlayers()->Array:
	var Players:Array
	
	for i in get_children():
		if i.alive:
			Players.append(i.name)
	
	return Players
