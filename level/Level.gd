extends Node2D
tool

export var size = Vector2(5,5) setget set_size
export var tiles = preload("res://level/flooring.png")
var running=false

# Called when the node enters the scene tree for the first time.
func _input(event):
	if not Engine.editor_hint and event.is_action_pressed("run"):
		if running:
			for obj in registry.all_things("run"):
				obj.stop()
		else:
			for obj in registry.all_things("run"):
				obj.start()
			registry.time=0
		running=not running

func set_size(new_size:Vector2):
	size=new_size
	update()

func _draw():
	for x in range(-size.x,size.x+1):
		for y in range(-size.y,size.y+1):
			var pos = Vector2(x,y)
			draw_texture(tiles,pos*16-Vector2(8,8))
