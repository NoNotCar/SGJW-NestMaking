extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spin=0
enum SIDE{
	START,
	MIDDLE,
	END,
	SHORT
}
var side_mode=SIDE.SHORT


# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"belt")
	registry.register(self,"blocked")
	$Sides.frame=1 if side_mode==SIDE.MIDDLE else 2 if side_mode==SIDE.SHORT else 0
	$Sides.rotation = PI if side_mode==SIDE.END else 0.0


func _process(delta):
	$Belt.frame=int(fposmod(registry.time*spin,0.5)*16)
