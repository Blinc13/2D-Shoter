extends Node

func _init():
	open()

var variables={
	"Sounds":1,
}

var gameSetUp={
	"Game":
	{
		"MaxPlayerHealth":100,
		"PlayerSpeedCof":1,
		"PlayerRespTime":10,
		"PlayerLives":5
	},
	"Server":
	{
		"MaxPlayers":4,
		"Ip":"192.168.0.103",
		"Port":8086
	}
}

func open():
	var save=File.new()
	if !save.open("user://Settings.json",File.READ):
		variables=parse_json(save.get_line())
	if !save.open("user://GameSetUp.json",File.READ):
		gameSetUp=parse_json(save.get_line())

func save():
	var save=File.new()
	save.open("user://Settings.json",File.WRITE)
	save.store_line(to_json(variables))
	save.open("user://GameSetUp.json",File.WRITE)
	save.store_line(to_json(gameSetUp))

func _exit_tree():
	save()
