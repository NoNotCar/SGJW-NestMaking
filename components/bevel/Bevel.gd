extends Node2D


var spin setget set_spin,get_spin
var spin_dir: Array
var axle_sync: int

# Called when the node enters the scene tree for the first time.
func _ready():
	spin_dir=[-lib.point(self)]
	registry.register(self,"gear",registry.tile_pos(global_position))
	axle_sync = 1 if lib.point(self) in [Vector2.DOWN,Vector2.LEFT] else -1
func _process(delta):
	$Sprite.frame=int(fposmod(registry.time*$Axle.spin,0.5)*4)
func set_spin(new):
	$Axle.spin=new*axle_sync
func get_spin():
	return $Axle.spin


func _on_Axle_spin_changed(axle):
	var a=lib.point(self)
	for gear in registry.find("gear",registry.tile_pos(global_position)+a):
		if a in gear.spin_dir:
			gear.spin=$Axle.spin*-axle_sync
