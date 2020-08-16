extends Node2D
tool
signal complete

export var size = Vector2(5,5) setget set_size
export var tiles = preload("res://level/flooring.png")
export var character = preload("res://gui/help/chicken.png")
export (String,MULTILINE) var goal_text = "Get the egg to the nest!"
export var music = preload("res://music/mountain.ogg")
var running=false

func _init():
	if not Engine.editor_hint:
		registry.reset()

# Called when the node enters the scene tree for the first time.
func _input(event):
	if not Engine.editor_hint and event.is_action_pressed("run"):
		if running:
			for obj in registry.all_things("run"):
				obj.stop()
			for error in get_tree().get_nodes_in_group("Errors"):
				error.queue_free()
		else:
			registry.errored=false
			for obj in registry.all_things("run"):
				obj.start()
			registry.time=0
		running=not running

func set_size(new_size:Vector2):
	size=new_size
	update()
	var z=0.06*new_size.y
	$Camera2D.zoom=Vector2(z,z)

func _draw():
	for x in range(-size.x,size.x+1):
		for y in range(-size.y,size.y+1):
			var pos = Vector2(x,y)
			draw_texture(tiles,pos*16-Vector2(8,8))
