extends VBoxContainer


const lselbox = preload("res://gui/LevelSelectBox.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(1,min(registry.MAX_LEVEL,registry.progress+1)+1):
		var ls = lselbox.instance()
		ls.text=str(n)
		ls.connect("pressed",self,"ls_press",[n])
		$CenterContainer/GridContainer.add_child(ls)


func ls_press(n):
	registry.level=n
	BlastDoors.close("res://Editor.tscn")
