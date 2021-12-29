extends Gun

func fire_event(vel:Vector2,pos:Vector2):
	Fire(Shell.instance(),vel,pos)
	playing=true

func alt_fire_event(vel:Vector2,pos:Vector2):
	Fire(AltShell.instance(),vel,pos)

func _on_m16_animation_finished():
	playing=false
	frame=0
