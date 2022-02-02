extends PanelContainer

class_name LevelItem

export(String) var LevelName="Level"
export(String) var ScenePath="res://Scenes/Levels/BetaLevel.tscn"

signal selected(path)

func _ready():
	$HBoxContainer/Label.text=LevelName


func _on_Button_pressed():
	emit_signal("selected",ScenePath)
