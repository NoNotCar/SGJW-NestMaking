extends Button


const start = preload("res://gui/startstop/start.png")
const stop = preload("res://gui/startstop/stop.png")
var running=false

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("run"):
		running=not running
		if running:
			icon=stop
		else:
			icon=start
func _on_pressed():
	var a = InputEventAction.new()
	a.action = "run"
	a.pressed = true
	Input.parse_input_event(a)
