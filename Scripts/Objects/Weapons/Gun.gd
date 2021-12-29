extends Weapon

class_name Gun

export(PackedScene) var Shell
export(PackedScene) var AltShell=null
export(float) var BulletBoost=1

onready var SoundObj=$AudioStreamPlayer2D
onready var Level=get_node("/root/Level")

func _ready():
	SoundObj.volume_db=GlobalVariables.variables["Sounds"]

func Fire(bullet,vel:Vector2,pos:Vector2):
	bullet.start(vel,pos,BulletBoost)
	Level.add_child(bullet)
	SoundObj.play(0)

