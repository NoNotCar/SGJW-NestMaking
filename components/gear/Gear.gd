extends Node2D


var spin:= 0.0 setget set_spin
var odd:=0
var spin_dir = lib.around
# Called when the node enters the scene tree for the first time.
func _ready():
	var tpos=registry.tile_pos(global_position)
	registry.register(self,"gear",tpos)
	registry.register(self,"blocked")
	odd = int(tpos.x+tpos.y)%2


func _process(delta):
	rotation=odd*TAU/16+spin*registry.time

func set_spin(new:float):
	if spin and new and new!=spin:
		registry.jam(self)
		return
	elif new==spin:
		return
	else:
		spin=new
		for a in lib.around:
			var tpos = registry.tile_pos(position)+a
			for gear in registry.find("gear",tpos):
				if a in gear.spin_dir:
					gear.spin=-new

