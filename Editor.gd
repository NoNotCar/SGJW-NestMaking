extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done:=false

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = load("res://level/Level%s.tscn" % registry.level).instance()
	$ViewportContainer/Viewport.add_child(level)
	$SideBar/VBoxContainer/CenterContainer/TextureRect.texture=level.character
	$SideBar/VBoxContainer/Chatbox.add_text(level.goal_text)
	level.connect("complete",self,"on_done")
	
func on_done():
	$SideBar/VBoxContainer/Chatbox.add_text("Well done! Press any key to proceed to the next stage!")
	done=true
	
func _input(event):
	if done and event is InputEventKey:
		registry.level+=1
		get_tree().reload_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
