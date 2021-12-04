extends Control
func _on_PlayBtn_pressed():
	visible=false
	get_tree().root.add_child(load("res://Scenes/Levels/BetaLevel.tscn").instance())
	print(SIZE_EXPAND)

func _on_SettingsBtn_pressed():
	if $TabContainer.visible == false:
		$TabContainer.visible = true
	else:
		$TabContainer.visible = false

func _on_ExitBtn_pressed():
	pass # Replace with function body.
