extends Node

signal update(string)

func send_event(string:String):
	emit_signal("update",string)
