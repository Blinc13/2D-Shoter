extends Level

class_name DeathMatch

export(int) var lives=2
export(NodePath) var PlayersController="NetworkPlayerController"

var lives_remain=lives

signal GameEnd(Winner)

func heroDead(hero):
	lives_remain-=1
	
	if lives_remain<1:
		Respawn=false
		rpc("DeadReg")

remote func DeadReg():
	var Players=get_node(PlayersController).GetAlivePlayers()
	
	if Players.size() == 2:
		Events.send_event("Player win: "+str(get_tree().get_rpc_sender_id()))
		emit_signal("GameEnd",Players[0])
