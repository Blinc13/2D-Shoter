extends Control

func _ready():
	$TabContainer/Audio/AudioVolume.value=GlobalVariables.variables["Sounds"]

func _on_PlayBtn_pressed():
	hide()
	get_tree().root.add_child(load("res://Scenes/Levels/BetaLevel.tscn").instance())

func _on_SettingsBtn_pressed():
	$TabContainer.visible = !$TabContainer.visible

func _on_ExitBtn_pressed():
	get_tree().quit()

func _on_AudioValume_value_changed(value):
	$TabContainer/Audio/Label2.text = str(value)
	GlobalVariables.variables["Sounds"]=value
