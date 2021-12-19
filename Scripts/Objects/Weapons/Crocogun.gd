extends Weapon

export(float) var bullet_boost
export(Texture) var uiIcon
export(PackedScene) var Bullet

onready var SoundObj=$AudioStreamPlayer2D

func _ready():
	SoundObj.volume_db=GlobalVariables.variables["Sounds"]

func fire_event(vel:Vector2,pos:Vector2):
	var node=Bullet.instance()
	node.start(vel,pos,bullet_boost)
	get_node("/root/Level").add_child(node)
	SoundObj.play(0)

func _process(delta):
	frame=rel/relTime*5
