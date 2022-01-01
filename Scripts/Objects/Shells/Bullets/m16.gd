extends Bullet

export(PackedScene) var DestEffect

func _physics_process(delta):
	bullet_update(delta)
	update_damp()


func destroy():
	var node=DestEffect.instance()
	get_parent().add_child(node)
	node.start(position)
