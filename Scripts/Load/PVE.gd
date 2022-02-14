extends Level

class_name pve

export(float) var GameDuration=200
var lives_remain=GlobalVariables.gameSetUp["Game"]["PlayerLives"]
var time:float=0

func hero_dead(hero):
	lives_remain-=1
	if lives_remain<1:
		CanRespawn=false
		set_process(false)

func _process(delta):
	time+=delta
	
	if time>GameDuration:
		Events.emit_signal("game_end","Player")
		set_process(false)
