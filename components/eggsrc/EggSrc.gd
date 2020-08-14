extends Node2D


const egg = preload("res://components/eggsrc/Egg.tscn")
var spawned

# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"run")

func start():
	spawned = egg.instance()
	spawned.position=position
	get_parent().add_child(spawned)
	$BeltSeg.spin=1

func stop():
	spawned.queue_free()
	$BeltSeg.spin=0
	
