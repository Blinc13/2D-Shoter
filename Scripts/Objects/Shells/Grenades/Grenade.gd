extends RigidBody2D

class_name Grenade

export(float) var speed=100
export(float) var explTime=6

var expload=false

func _ready():
	$Timer.start(explTime)

func start(vel:Vector2,pos:Vector2):
	position=pos
	linear_velocity=vel*speed

func effect(obj):
	pass

func _on_Timer_timeout():
	if !expload:
		$AnimatedSprite.play("Explosion")
		$AnimatedSprite.global_rotation=0
		linear_velocity=Vector2(0,0)
		angular_velocity=0
		
		
		effect($DamageArea.get_overlapping_bodies())
		$Timer.start(1)
		
		$SoundPlayer.play(0)
		set_collision_mask_bit(0,false)
		expload=true
	else:
		queue_free()

