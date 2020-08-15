extends Button


export var spawn = "gear"
export (String,MULTILINE) var info = "an object"
signal show_info


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_pressed():
	registry.placing=spawn
	if registry.level==1:
		emit_signal("show_info",info)
