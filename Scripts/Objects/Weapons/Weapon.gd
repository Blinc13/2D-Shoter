extends AnimatedSprite
class_name Weapon

export(float) var relTime
export(float) var BulletBoost
export(PackedScene) var Bullet

var reload:float

func _init():
	position=Vector2(0,10)

func _process(delta):
	reload+=delta

func fire(vel:Vector2,pos:Vector2):
	var node=Bullet.instance()
	reload=0
	node.start(vel,pos,BulletBoost)
	get_node("/root/Level").add_child(node)
