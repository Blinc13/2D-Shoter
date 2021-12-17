extends Weapon

export(float) var bullet_boost
export(Texture) var uiIcon
export(PackedScene) var Bullet

func fire_event(vel:Vector2,pos:Vector2):
	var node=Bullet.instance()
	node.start(vel,pos,bullet_boost)
	get_node("/root/Level").add_child(node)
