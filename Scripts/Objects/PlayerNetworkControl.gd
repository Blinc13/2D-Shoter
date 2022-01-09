extends Node

class_name PlayerNetworkController
onready var PlayerNode=get_node("1")
onready var DrawingObj=PlayerNode.get_node("Drawing")

var Weapons={
	"m16":load("res://Scenes/Weapons/Guns/m16.tscn"),
	"Crocogun":load("res://Scenes/Weapons/Guns/Crocogun.tscn"),
	"RocketLauncher":load("res://Scenes/Weapons/Guns/RocketLauncher.tscn"),
	"Pistol":load("res://Scenes/Weapons/Guns/Pistol.tscn")
}

var PlayerStateCopy:Dictionary

remote func init():
	var List=rpc_id(1,"GetPlayersList")
	print_debug("Init")

func _process(delta):
	PlayerNode.rpc_unreliable("set_position",PlayerNode.position)
	PlayerNode.rpc_unreliable("set_rotation",PlayerNode.DrawingObj.rotation)

func _on_1_Fire(vec, pos):
	PlayerNode.weapon.rpc("fire",vec,pos)

func PlayerInventoryChanged():
	rpc(AddWeaponToPlayerInventory(GetPlayerWeaponsNames(PlayerNode).back()))

func PlayerWeaponChanged(weapon):
	PlayerNode.rpc("ch_weapon")

remote func AddWeaponToPlayerInventory(name:String):
	var PlayerID=get_tree().get_rpc_sender_id()
	get_node(str(PlayerID)+"/Drawing/Weapons").add_child(Weapons[name].instance())

remote func GetPlayersList()->Dictionary:
	var Players:Dictionary
	
	for i in get_child_count():
		var PlayerState:Dictionary
		
		PlayerState["P"]=get_child(i).position
		PlayerState["A"]=get_child(i).DrawingObj.rotation
		PlayerState["I"]=GetPlayerWeaponsNames(get_child(i))
	
	return Players

func GetPlayerWeaponsNames(node)->Array:
	var inventory=node.get_node("Drawing/Weapons").get_children()
	var inventoryNames:Array
	
	for i in inventory:
		inventoryNames.append(i.name)
	
	print_debug(inventoryNames)
	return inventoryNames
