extends Item

class_name GunItem

export(PackedScene) var Gun

var Name:String

func _ready():
	Name=Gun.get_state().get_node_name(0)

func use_item(obj):
	if obj is Hero:
		if obj.get_child(0).get_node(Name) != null:
			pass
		else:
			obj.get_child(0).add_child(Gun.instance())
