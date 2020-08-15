extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("check")


func check():
	if registry.errored:
		return
	for belt in registry.find("belt",registry.tile_pos(global_position)):
		var dir = lib.point(belt,Vector2.RIGHT)*belt.spin
		if dir:
			$Tween.interpolate_property(self,"position",position,position+dir.normalized()*16,1/float(abs(belt.spin)),Tween.TRANS_LINEAR)
			$Tween.start()
		return
	for nest in registry.find("nest",registry.tile_pos(global_position)):
		remove_from_group("Eggs")
		nest.eggs+=1
		queue_free()
		return
	$Sprite.frame=1


func _on_tween_all_completed():
	check()
