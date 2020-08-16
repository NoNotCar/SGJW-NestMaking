extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var reversed=false


# Called when the node enters the scene tree for the first time.
func _ready():
	if reversed:
		$Sprite.frame=2
	registry.register(self,"run")


func start():
	$Axle.spin=-1 if reversed else 1
	
func stop():
	$Axle.spin=0
	$Sprite.frame=2 if reversed else 1
	
func reverse():
	var rspin=-$Axle.spin
	$Axle.spin=0
	$Axle.spin=rspin
	$Sprite.frame=3-$Sprite.frame


func _on_area_entered(area):
	reverse()
