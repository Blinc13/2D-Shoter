extends Rocket

export(float) var damage=50

func explosion():
	for i in $Lesion.get_overlapping_bodies():
		if i.is_in_group("Entity"):
			i.damage(damage)
