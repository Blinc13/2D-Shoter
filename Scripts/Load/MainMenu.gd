extends Control

func _ready():
	$Settings/Audio/VBoxContainer/VBoxContainer2/VBoxContainer/AudioVolume.value=GlobalVariables.variables["Sounds"]
	
	$Settings/Game/ScrollArea/Widgets/RespTime/LineEdit.text=str(GlobalVariables.gameSetUp["Game"]["PlayerRespTime"])
	$Settings/Game/ScrollArea/Widgets/PlayerSpeed/LineEdit.text=str(GlobalVariables.gameSetUp["Game"]["PlayerSpeedCof"])
	$Settings/Game/ScrollArea/Widgets/PlayerMaxHealth/LineEdit.text=str(GlobalVariables.gameSetUp["Game"]["MaxPlayerHealth"])
	
	$Settings/Server/ScrollArea/Widgets/Ip/LineEdit.text=str(GlobalVariables.gameSetUp["Server"]["Ip"])
	$Settings/Server/ScrollArea/Widgets/MaxPlayers/LineEdit.text=str(GlobalVariables.gameSetUp["Server"]["MaxPlayers"])
	$Settings/Server/ScrollArea/Widgets/Port/LineEdit.text=str(GlobalVariables.gameSetUp["Server"]["Port"])

func _on_PlayBtn_pressed():
	hide()
	get_tree().root.add_child(load("res://Scenes/Levels/BetaLevel.tscn").instance())

func _on_SettingsBtn_pressed():
	$Settings.visible = !$Settings.visible

func _on_ExitBtn_pressed():
	get_tree().quit()

func _on_AudioValume_value_changed(value):
	GlobalVariables.variables["Sounds"]=value


func MaxPlayersEdit(MaxPlayers:String):
	GlobalVariables.gameSetUp["Server"]["MaxPlayers"]=int(MaxPlayers)
func IpEdit(Ip:String):
	GlobalVariables.gameSetUp["Server"]["Ip"]=int(Ip)
func PortEdit(Port:String):
	GlobalVariables.gameSetUp["Server"]["Port"]=int(Port)
func HealthEdit(MaxHealth:String):
	GlobalVariables.gameSetUp["Game"]["MaxPlayerHealth"]=int(MaxHealth)
func SpeedEdit(PlayerSpeed:String):
	GlobalVariables.gameSetUp["Game"]["PlayerSpeedCof"]=float(PlayerSpeed)
func RespTimeEdit(RespTime:String):
	GlobalVariables.gameSetUp["Game"]["PlayerRespTime"]=float(RespTime)
