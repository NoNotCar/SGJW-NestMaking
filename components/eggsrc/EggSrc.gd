extends Node2D


export var egg = preload("res://components/eggsrc/Egg.tscn")
export var cover = 0
var spawned

# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"run")
	$Sprite.frame=cover

func start():
	spawned = egg.instance()
	spawned.position=position
	get_parent().add_child(spawned)
	$BeltSeg.spin=1

func stop():
	if spawned:
		spawned.queue_free()
	$BeltSeg.spin=0
	
