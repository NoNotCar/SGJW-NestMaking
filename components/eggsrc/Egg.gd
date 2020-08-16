extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fixed = false
var fpos:Vector2
export var target_nest = "nest"
# Called when the node enters the scene tree for the first time.
func _ready():
	if fixed:
		fpos=position
		remove_from_group("Eggs")
		registry.register(self,"run")
	else:
		call_deferred("check")


func check():
	$Tween.remove_all()
	if registry.errored:
		return
	for belt in registry.find("belt",registry.tile_pos(global_position)):
		var dir = lib.point(belt,Vector2.RIGHT)*belt.spin
		if dir:
			$Tween.interpolate_property(self,"position",position,position+dir.normalized()*16,1/float(abs(belt.spin)),Tween.TRANS_LINEAR)
			$Tween.start()
		return
	if $Sprite.frame==0:
		for nest in registry.find(target_nest,registry.tile_pos(global_position)):
			if nest.eggs!=nest.max_eggs:
				remove_from_group("Eggs")
				nest.eggs+=1
				queue_free()
				return
	$Sprite.frame=1


func _on_tween_all_completed():
	check()


func _on_area_entered(area):
	if area.get_parent() in get_tree().get_nodes_in_group("Eggs"):
		$Sprite.frame=1
		
func start():
	call_deferred("check")
func stop():
	$Tween.remove_all()
	position=fpos
	$Sprite.frame=0
