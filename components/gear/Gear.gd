extends Node2D


export var test_drive = false
var spin:= 0 setget set_spin
var odd:=0

# Called when the node enters the scene tree for the first time.
func _ready():
	var tpos=registry.tile_pos(position)
	registry.register(self,"gear",tpos)
	odd = int(tpos.x+tpos.y)%2


func _process(delta):
	if test_drive and not spin:
		set_spin(1)
	rotation=odd*TAU/16+spin*registry.time

func set_spin(new:int):
	if spin and new!=spin:
		print("KILLA BEE GOT STUNG")
		push_error("TODO: this...")
		return
	elif new==spin:
		return
	else:
		spin=new
		for a in lib.around:
			var tpos = registry.tile_pos(position)+a
			for gear in registry.find("gear",tpos):
				gear.spin=-new

