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

remote func init(List:Dictionary):
	print_debug("Init !: ",List)
	for i in List.keys():
		var node=PlayerTemplate.instance()
		
		node.name=i
		node.position=List[i]["P"]
		
		add_child(node)
		
		node.DrawingObj.rotation=List[i]["A"]

func _process(delta):
	PlayerNode.rpc_unreliable("set_position",PlayerNode.position)
	PlayerNode.rpc_unreliable("set_rotation",PlayerNode.DrawingObj.rotation)

func _on_1_Fire(vec, pos):
	PlayerNode.weapon.rpc("fire",vec,pos)

func PlayerInventoryChanged(WeaponName):
	rpc("AddWeaponToPlayerInventory",WeaponName)

func PlayerWeaponChanged(weapon):
	PlayerNode.rpc("ch_weapon",weapon.name)

remote func AddWeaponToPlayerInventory(name:String):
	var PlayerID=get_tree().get_rpc_sender_id()
	get_node(str(PlayerID)).WeaponsList.add_child(Weapons[name].instance())

func GetPlayersList()->Dictionary:
	var Players:Dictionary
	
	for i in get_child_count():
		var PlayerState:Dictionary
		var Player=get_child(i)
		
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
