extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done:=false
var level
const selclass = preload("res://gui/selectbox/SelectBox.gd")
const lnames = ["Start","Confluence","Oscillate","Split","Penguin","Final"]
# Called when the node enters the scene tree for the first time.
func _ready():
	level = load("res://level/%s.tscn" % lnames[registry.level-1]).instance()
	$ViewportContainer/Viewport.add_child(level)
	$SideBar/VBoxContainer/CenterContainer/TextureRect.texture=level.character
	level.connect("complete",self,"on_done")
	BlastDoors.connect("opened",self,"on_open")
	for selector in $SideBar/CenterContainer/GridContainer.get_children():
		if selector is selclass:
			selector.connect("show_info",$SideBar/VBoxContainer/Chatbox,"add_text")
func on_open():
	$SideBar/VBoxContainer/Chatbox.add_text(level.goal_text)
	$Music.stream=level.music
	$Music.play()
	
func on_done():
	registry.save_progress()
	if registry.level==registry.MAX_LEVEL:
		$SideBar/VBoxContainer/Chatbox.add_text("Well done! You've completed all the stages!")
	else:
		$SideBar/VBoxContainer/Chatbox.add_text("Well done! Press any key to proceed to the next stage!")
		done=true
	
func _input(event):
	if done and event is InputEventKey:
		registry.level+=1
		BlastDoors.close()
		done=false
		$Music.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
