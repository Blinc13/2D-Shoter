extends RigidBody2D

class_name Bullet

export(float) var speed=300
export(float) var damage=0.2

var pas=true
var destroy=false

func start(point:Vector2,pos:Vector2):
	linear_velocity=point*speed
	position=pos
	rotate(point.angle())
	print(typeof(linear_damp))
	$AnimatedSprite.playing=true

func _physics_process(delta:float):
	if linear_velocity.length()<3 and pas:
		$AnimatedSprite.play("Destroy")
		$Timer.start(0.18)
		pas=false
	if destroy:
		free()

func damage(vel:Vector2):
	return int(damage*(linear_velocity-vel).length()/2)

func _on_Timer_timeout():
	#print("What the fuck ?")
	destroy=true
