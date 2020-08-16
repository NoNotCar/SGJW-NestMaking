extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const sfile = "user://volume.sav"

# Called when the node enters the scene tree for the first time.
func _ready():
	var d=Directory.new()
	if d.file_exists(sfile):
		var f=File.new()
		f.open(sfile,File.READ)
		$CenterContainer/HSlider.value=f.get_var()
		f.close()
	_on_HSlider_value_changed($CenterContainer/HSlider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	var dB=value*0.5-50
	if value:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), dB)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
func _exit_tree():
	var f=File.new()
	f.open(sfile,File.WRITE)
	f.store_var($CenterContainer/HSlider.value)
	f.close()
	
