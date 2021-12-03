extends RigidBody2D

export(float) var speed=100
export(float) var damage=30
export(float) var explTime=6

var expload=false

func _ready():
	$Timer.start(explTime)

func start(vel:Vector2,pos:Vector2):
	position=pos
	linear_velocity=vel*speed

func _process(delta):
	#print("Frame")
	pass


func _on_Timer_timeout():
	if !expload:
		$AnimatedSprite.play("Explosion")
		$AnimatedSprite.global_rotation=0
		linear_velocity=Vector2(0,0)
		angular_velocity=0
		
		$Timer.start(1)
		
		for i in $DamageArea.get_overlapping_bodies():
			if i.is_in_group("Entity"):
				i.damage(damage)
		
		$AudioStreamPlayer2D.play(0)
		set_collision_mask_bit(0,false)
		expload=true
	else:
		queue_free()

