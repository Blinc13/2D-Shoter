extends AnimatedSprite

class_name Weapon

export(float) var relTime
export(float) var altRelTime
export(Texture) var uiIcon

var rel:float
var altRel:float
var reloaded:bool
var altReloaded:bool

func _process(delta):
	rel+=delta
	altRel+=delta
	if rel>=relTime:
		reloaded=true
		reloaded()
	if altRel>=altRelTime:
		altReloaded=true
		alt_reloaded()

func fire_event(vel:Vector2,pos:Vector2):
	pass

func alt_fire_event(vel:Vector2,pos:Vector2):
	pass

remote func fire(vel:Vector2,pos:Vector2):
	rel=0
	reloaded=false
	fire_event(vel,pos)

remote func altFire(vel:Vector2,pos:Vector2):
	altRel=0
	altReloaded=false
	alt_fire_event(vel,pos)

func isReloaded():
	return reloaded
func altIsReloaded():
	return altReloaded

func reloaded():
	pass
func alt_reloaded():
	pass
