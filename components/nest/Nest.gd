extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var eggs:=0 setget set_eggs

# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"nest")


func set_eggs(new:int):
# warning-ignore:narrowing_conversion
	eggs=clamp(new,0,3)
	$Sprite.frame=eggs
	if eggs:
		get_tree().change_scene("res://gui/Congratulations.tscn")
