extends RigidBody2D

class_name Bullet

export(float) var windage=0.001
export(float) var speed=300
export(float) var damage=0.2

func start(point:Vector2,pos:Vector2):
	linear_velocity=point*speed
	position=pos
	rotate(point.angle())
	$AnimatedSprite.playing=true

func _physics_process(delta):
	linear_velocity-=linear_velocity*(windage*delta)
	if linear_velocity.length()<5:
		free()

func damage():
	return int(damage*linear_velocity.length()/2)

func _on_Timer_timeout():
	print("What the fuck ?")
