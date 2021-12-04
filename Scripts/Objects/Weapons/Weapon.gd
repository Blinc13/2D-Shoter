extends AnimatedSprite
class_name Weapon

export(float) var relTime

export(PackedScene) var Bullet

func _init():
	position=Vector2(0,10)

func fire(vel:Vector2,pos:Vector2):
	var node=Bullet.instance()
	node.start(vel,pos)
	get_node("/root/Level").add_child(node)
