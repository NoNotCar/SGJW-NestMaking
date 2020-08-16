extends Node


const around = [Vector2.UP,Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func point(thing:Node2D,forwards:=Vector2.UP)->Vector2:
	return forwards.rotated(thing.global_rotation).snapped(Vector2.ONE)
func rpoint(dir:Vector2,forwards:=Vector2.UP)->float:
	return forwards.angle_to(dir)
func iterrow(pos1:Vector2, pos2:Vector2):
	var dir = pos2-pos1
	var idir=dir.normalized()
	var res=[]
	for n in range(int(dir.length())+1):
		res.append(pos1+idir*n)
	return res
func aniframe(period:float,frames:int,spin:float):
	return int(fposmod(registry.time*spin,period)*frames/period)
func try_load(sfile,default):
	var d=Directory.new()
	var result=default
	if d.file_exists(sfile):
		var f=File.new()
		f.open(sfile,File.READ)
		result=f.get_var()
		f.close()
	return result
func save(sfile,value):
	var f=File.new()
	f.open(sfile,File.WRITE)
	f.store_var(value)
	f.close()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
