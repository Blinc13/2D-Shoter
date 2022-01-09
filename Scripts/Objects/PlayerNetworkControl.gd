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

func _process(delta):
	var PlayerStats={
		"P":PlayerNode.position,
		"H":PlayerNode.health,
		"A":DrawingObj.rotation,
	}
	Server.SendPlayerState(PlayerStats)

remote func _update(State:Dictionary):
	for i in State.keys():
		var node=get_node_or_null(str(i))
		if node == null:
			get_parent().spawn_player(str(i))
		elif get_tree().get_network_unique_id() != i:
			node.position=State[i]["P"]
			node.rotation=State[i]["A"]
			
			if GetPlayerWeaponsNames(node).size() != State[i]["I"].size():
				var list=node.get_node("Drawing/Weapons")
				
				list.add_child(Weapons[State[i]["I"].back()].instance())


func _on_1_Fire(vec, pos):
	PlayerNode.weapon.rpc("fire",vec,pos)

func PlayerInventoryChanged():
	Server.SendInventoryState(GetPlayerWeaponsNames(PlayerNode).back())

func PlayerWeaponChanged(weapon):
	pass

func GetPlayerWeaponsNames(node)->Array:
	var inventory=node.get_node("Drawing/Weapons").get_children()
	var inventoryNames:Array
	
	for i in inventory:
		inventoryNames.append(i.name)
	
	print_debug(inventoryNames)
	return inventoryNames
