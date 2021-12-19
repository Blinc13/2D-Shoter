extends Grenade

export(float) var damage=20


func effect(obj):
	for i in obj:
		if i.is_in_group("Entity"):
			i.damage(damage)
