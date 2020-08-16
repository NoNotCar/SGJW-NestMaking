extends Tween


export(float,0.0,1.0) var x_scale=0.0
export(float,0.0,1.0) var y_scale=0.0
const TIME = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() is Node2D:
		get_parent().scale=Vector2.ZERO
		interpolate_property(get_parent(),"scale",Vector2(x_scale,y_scale),Vector2.ONE,TIME,Tween.TRANS_CUBIC)
		start()

#func scale_out():
#	if get_parent() is Node2D:
#		get_parent().scale=Vector2.ZERO
#		interpolate_property(get_parent(),"scale",Vector2(x_scale,y_scale),Vector2.ONE,TIME,Tween.TRANS_CUBIC)
#		start()
