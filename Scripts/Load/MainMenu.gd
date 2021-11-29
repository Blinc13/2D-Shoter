extends Control

func _on_Button_pressed():
	visible=false
	get_tree().root.add_child(load("res://Scenes/Levels/BetaLevel.tscn").instance())
	print(SIZE_EXPAND)
