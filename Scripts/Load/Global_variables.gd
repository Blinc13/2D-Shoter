extends Node

func _init():
	var save=File.new()
	if !save.open("user://Settings.json",File.READ):
		variables=parse_json(save.get_line())

var variables={
	"Sounds":1,
}

func _exit_tree():
	var save=File.new()
	save.open("user://Settings.json",File.WRITE)
	save.store_line(to_json(variables))
