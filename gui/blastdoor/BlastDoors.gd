extends CanvasLayer


var open:=false
signal opened
var override_scene=""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func close(next_scene=""):
	override_scene=next_scene
	if open:
		$AnimationPlayer.play_backwards("Open")

func _on_AnimationPlayer_animation_finished(anim_name):
	open=not open
	if not open:
		$Timer.start()
		if override_scene:
			get_tree().change_scene(override_scene)
		else:
			get_tree().reload_current_scene()
	else:
		emit_signal("opened")


func _on_Timer_timeout():
	$AnimationPlayer.play("Open")
