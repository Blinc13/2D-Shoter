extends AnimatedSprite

enum Ammo{m16,ener}

class_name Weapon

export(float) var relTime
export(float) var altRelTime

var rel:float
var altRel:float
var reloaded:bool
var altReloaded:bool

func _init():
	position=Vector2(0,10)

func _process(delta):
	rel+=delta
	altRel+=delta
	if rel>=relTime:
		reloaded=true
	if altRel>=altRelTime:
		altReloaded=true

func fire_event(vel:Vector2,pos:Vector2):
	pass

func alt_fire_event(vel:Vector2,pos:Vector2):
	pass

func fire(vel:Vector2,pos:Vector2):
	rel=0
	reloaded=false
	fire_event(vel,pos)

func altFire(vel:Vector2,pos:Vector2):
	altRel=0
	altReloaded=false
	alt_fire_event(vel,pos)
