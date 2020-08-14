extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("check")


func check():
	for belt in registry.find("belt",registry.tile_pos(global_position)):
		var dir = lib.point(belt,Vector2.RIGHT)*belt.spin
		if dir:
			$Tween.interpolate_property(self,"position",position,position+dir*16,belt.spin,Tween.TRANS_LINEAR)
			$Tween.start()
		return


func _on_tween_all_completed():
	check()
