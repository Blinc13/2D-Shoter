extends Node

class_name PlayerNetworkController
onready var PlayerNode=get_node("1")

func _process(delta):
	Server.SendPosition(PlayerNode.position)

remote func _update(State):
	for i in State.keys():
		var node=get_node_or_null(str(i))
		if node == null:
			get_parent().spawn_player(str(i))
		elif get_tree().get_network_unique_id() != i:
			get_node(str(i)).position=State[i]
