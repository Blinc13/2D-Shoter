extends Gun

onready var RelParticles=$Particles2D

func fire_event(vel:Vector2,pos:Vector2):
	Fire(Shell.instance(),vel,pos)
	RelParticles.emitting=false

func reloaded():
	RelParticles.emitting=true
