extends Node2D


var spin setget set_spin,get_spin
var spin_dir: Array
export (float) var ratio = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	spin_dir=[-lib.point(self)]
	registry.register(self,"gear",registry.tile_pos(global_position))
func _process(delta):
	$Sprite.frame=int(fposmod(registry.time*$Axle.spin,0.5)*8)
func set_spin(new):
	$Axle.spin=-new*ratio
func get_spin():
	return $Axle.spin/ratio


func _on_Axle_spin_changed(axle):
	var a=lib.point(self)
	for gear in registry.find("gear",registry.tile_pos(global_position)+a):
		if a in gear.spin_dir:
			gear.spin=get_spin()
