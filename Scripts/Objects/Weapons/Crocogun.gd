extends Weapon

export(float) var bullet_boost
export(PackedScene) var Bullet
export(PackedScene) var Gren

func fire_event(vel:Vector2,pos:Vector2):
	var node=Bullet.instance()
	node.start(vel,pos,bullet_boost)
	get_node("/root/Level").add_child(node)

func alt_fire_event(vel:Vector2,pos:Vector2):
	var node=Gren.instance()
	node.start(vel,pos)
	get_node("/root/Level").add_child(node)
