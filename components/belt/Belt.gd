extends Node2D


export var length = 3
const axle := preload("res://components/axle/Axle.tscn")
const beltseg:=preload("res://components/belt/BeltSeg.tscn")
var axles=[]
var segs=[]
var axle_sync:int

# Called when the node enters the scene tree for the first time.
func _ready():
	axle_sync = -1 if lib.point(self) in [Vector2.DOWN,Vector2.LEFT] else 1
	for n in range(length):
		if n==0 or n==length-1:
			var a = axle.instance()
			a.position=Vector2(n*16,0)
			a.connect("spin_changed",self,"on_axle_speed_change")
			add_child(a)
			axles.append(a)
		var bs = beltseg.instance()
		bs.position=Vector2(n*16,0)
		bs.side_mode=bs.SIDE.SHORT if length==1 else bs.SIDE.END if n==length-1 else bs.SIDE.MIDDLE if n else bs.SIDE.START
		add_child(bs)
		segs.append(bs)

func on_axle_speed_change(axle):
	for a in axles:
		if a!=axle:
			a.spin=axle.spin
	for bs in segs:
		bs.spin=axle.spin*axle_sync
