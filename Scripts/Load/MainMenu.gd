extends Control

func _ready():
	$Settings/Audio/VBoxContainer/VBoxContainer2/VBoxContainer/AudioVolume.value=GlobalVariables.variables["Sounds"]
	
	$Settings/Game/ScrollArea/Widgets/RespTime/LineEdit.text=str(GlobalVariables.gameSetUp["Game"]["PlayerRespTime"])
	$Settings/Game/ScrollArea/Widgets/PlayerSpeed/LineEdit.text=str(GlobalVariables.gameSetUp["Game"]["PlayerSpeedCof"])
	$Settings/Game/ScrollArea/Widgets/PlayerMaxHealth/LineEdit.text=str(GlobalVariables.gameSetUp["Game"]["MaxPlayerHealth"])
	
	$Settings/Server/ScrollArea/Widgets/Ip/LineEdit.text=str(GlobalVariables.gameSetUp["Server"]["Ip"])
	$Settings/Server/ScrollArea/Widgets/MaxPlayers/LineEdit.text=str(GlobalVariables.gameSetUp["Server"]["MaxPlayers"])
	$Settings/Server/ScrollArea/Widgets/Port/LineEdit.text=str(GlobalVariables.gameSetUp["Server"]["Port"])
	
	Server.connect("Connected",self,"Pconnected")
	Server.connect("Disconnected",self,"Pdisconnect")

func _on_Start_pressed():
	if $NetworkMenu.visible:
		Server.StopServer()
		$NetworkMenu.visible=false
	else:
		$NetworkMenu.visible=true

func _on_Play_pressed():
	$LevelList.visible = !$LevelList.visible

func _on_SettingsBtn_pressed():
	$Settings.visible = !$Settings.visible

func _on_ExitBtn_pressed():
	get_tree().quit()

func _on_AudioValume_value_changed(value):
	GlobalVariables.variables["Sounds"]=value

func LevelSelected(path:String):
	Server.Map=path


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


func Server_start():
	Server.StartServer()
func Client_start():
	Server.StartClient()
func start_game():
	if Server.isServer:
		Server.start_game()
		visible=false

func Pconnected(id:int):
	var node=Label.new()
	var name=str(id)
	
	node.name=name
	node.text=name
	
	$NetworkMenu/VBoxContainer/PlayersList.add_child(node)
func Pdisconnect(id:int):
	get_node("NetworkMenu/VBoxContainer/PlayersList/"+str(id)).queue_free()
