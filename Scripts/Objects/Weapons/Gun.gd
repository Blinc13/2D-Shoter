extends Weapon

class_name Gun

export(PackedScene) var Bullet
export(float) var BulletBoost=1

onready var SoundObj=$AudioStreamPlayer2D
onready var Level=get_node("/root/Level")

func Fire(bullet,vel:Vector2,pos:Vector2):
	bullet.start(vel,pos,BulletBoost)
	Level.add_child(bullet)
	SoundObj.play(0)

func _process(delta):
	frame=rel/relTime*frames.get_frame_count("Reload")
