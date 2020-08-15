extends "res://components/eggsrc/Egg.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const freeze=preload("res://gui/alerts/Frozen.tscn")
var ice=0.0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	ice+=delta*0.1
	ice=min(ice,1)
	$Sprite.modulate=Color(1-ice*0.3,1-ice*0.3,1)
	if ice==1:
		registry.jam(self,freeze)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
