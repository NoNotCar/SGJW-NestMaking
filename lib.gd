extends Node


const around = [Vector2.UP,Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func point(thing:Node2D,forwards:=Vector2.UP):
	return forwards.rotated(thing.global_rotation).snapped(Vector2.ONE)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
