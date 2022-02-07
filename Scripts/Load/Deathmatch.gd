extends Level

class_name DeathMatch

var lives_remain=GlobalVariables.gameSetUp["Game"]["PlayerLives"]

func heroDead(hero):
	lives_remain-=1
	
	if lives_remain<1:
		CanRespawn=false
		rpc("DeadReg")

remote func DeadReg():
	var Players=get_node(PlayerControllNode).GetAlivePlayers()
	
	if Players.size() == 2:
		Events.emit_signal("game_end",Player[0])
