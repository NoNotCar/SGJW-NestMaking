extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var eggs:=0 setget set_eggs

# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"nest")
	registry.register(self,"blocked")
	registry.register(self,"run")

func start():
	set_eggs(0)
func stop():
	set_eggs(0)
func set_eggs(new:int):
# warning-ignore:narrowing_conversion
	eggs=clamp(new,0,$Sprite.hframes-1)
	$Sprite.frame=eggs
	if not get_tree().get_nodes_in_group("Eggs"):
		for nest in get_tree().get_nodes_in_group("Nests"):
			if not nest.eggs:
				return
		get_parent().emit_signal("complete")
