extends Node


const around = [Vector2.UP,Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func point(thing:Node2D,forwards:=Vector2.UP)->Vector2:
	return forwards.rotated(thing.global_rotation).snapped(Vector2.ONE)
func iterrow(pos1:Vector2, pos2:Vector2):
	var dir = pos2-pos1
	var idir=dir.normalized()
	var res=[]
	for n in range(int(dir.length())+1):
		res.append(pos1+idir*n)
	return res
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
