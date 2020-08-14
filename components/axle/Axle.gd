extends Node2D

signal spin_changed
export var test_drive = false
var spin:= 0 setget set_spin
var hoz:bool
var rot:bool
export var cull_front = false
export var cull_back = false

# Called when the node enters the scene tree for the first time.
func _ready():
	registry.register(self,"axle")
	registry.register(self,"blocked")
	hoz=lib.point(self).x
	rot=lib.point(self).y>0 or lib.point(self).x<0
	if cull_front:
		$Sprite.region_rect=Rect2(0,2,64,14)
		$Sprite.offset=Vector2.DOWN
	elif cull_back:
		$Sprite.region_rect=Rect2(0,0,64,14)
		$Sprite.offset=Vector2.UP

func _process(delta):
	if test_drive and not spin:
		set_spin(1)
	$Sprite.frame=int(fposmod(registry.time*spin+0.25*int(rot),1)*4)

func set_spin(new:int):
	if spin and new!=spin:
		print(global_position)
		push_error("TODO: this as well...")
		return
	elif new==spin:
		return
	else:
		spin=new
		emit_signal("spin_changed",self)
		for a in ([Vector2.RIGHT,Vector2.LEFT] if hoz else [Vector2.UP,Vector2.DOWN]):
			var tpos = registry.tile_pos(global_position)+a
			for axle in registry.find("axle",tpos):
				if axle.hoz==hoz:
					axle.spin=new if axle.rot==rot else -new
