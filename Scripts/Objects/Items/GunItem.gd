extends Item

class_name GunItem

export(PackedScene) var Gun

func use_item(obj):
	if obj is Hero:
		obj.get_child(0).add_child(Gun.instance())
