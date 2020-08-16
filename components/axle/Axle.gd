extends Node2D

signal spin_changed
var spin:= 0.0 setget set_spin
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
	$Sprite.frame=int(fposmod(registry.time*spin+0.249*int(rot),1)*4)

func get_transference()->Array:
	var l=[Vector2.RIGHT,Vector2.LEFT] if hoz else [Vector2.UP,Vector2.DOWN]
	if rot:
		l.invert()
	if cull_front:
		l.pop_front()
	elif cull_back:
		l.pop_back()
	return l
func set_spin(new:float):
	if spin and new and new!=spin:
		registry.jam(self)
		return
	elif new==spin:
		return
	else:
		spin=new
		emit_signal("spin_changed",self)
		for a in get_transference():
			var tpos = registry.tile_pos(global_position)+a
			for axle in registry.find("axle",tpos):
				if -a in axle.get_transference():
					axle.spin=new if axle.rot==rot else -new
