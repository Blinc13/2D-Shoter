extends Grenade

export(float) var damage=20
export(Array) var gh


func effect(obj):
	for k in gh:
		for i in obj:
			if i.is_in_group(k):
				i.damage(damage)
