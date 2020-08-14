extends Node2D

signal spin_changed
export var test_drive = false
var spin:= 0 setget set_spin
var hoz:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"axle",registry.tile_pos(global_position))
	hoz=lib.point(self).x
	if hoz:
		global_rotation=PI/2
	else:
		global_rotation=0

func _process(delta):
	if test_drive and not spin:
		set_spin(1)
	$Sprite.frame=int(fposmod(registry.time*spin,1)*4)

func set_spin(new:int):
	if spin and new!=spin:
		push_error("TODO: this as well...")
		return
	elif new==spin:
		return
	else:
		spin=new
		emit_signal("spin_changed")
		for a in ([Vector2.RIGHT,Vector2.LEFT] if hoz else [Vector2.UP,Vector2.DOWN]):
			var tpos = registry.tile_pos(global_position)+a
			for axle in registry.find("axle",tpos):
				if axle.hoz==hoz:
					axle.spin=new
