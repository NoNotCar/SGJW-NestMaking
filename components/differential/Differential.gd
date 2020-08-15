extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var driving=[]
var driven
var axles=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_children():
		if c!=$Sprite:
			c.connect("spin_changed",self,"on_axle_spin_change")
			axles.append(c)

func _process(delta):
	$Sprite.frame=lib.aniframe(0.3,3,-$Axle3.spin)

func on_axle_spin_change(axle):
	if axle.spin==0 and axle in driving:
		driving = []
		driven.spin=0
		driven=null
		return
	if axle==driven:
		return
	var tar_spin
	if $Axle.spin:
		if $Axle2.spin:
			driving = [$Axle,$Axle2]
			driven=$Axle3
			tar_spin=-($Axle.spin+$Axle2.spin)/2.0
		elif $Axle3.spin:
			driving = [$Axle,$Axle3]
			driven=$Axle2
			tar_spin=-$Axle3.spin*2-$Axle.spin
	elif $Axle2.spin and $Axle3.spin:
		driving=[$Axle2,$Axle3]
		driven=$Axle
		tar_spin=-$Axle3.spin*2-$Axle2.spin
	if driven:
		if driven.spin==0:
			driven.spin=tar_spin
		elif driven.spin!=tar_spin:
			registry.jam(self)
