extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _reg:={}
var lookup:={}
var time=0
var placing = "gear"
var errored:=false
var level = 1
var progress = 0
var sfile = "user://progress.sav"
const MAX_LEVEL = 6
const jam_error = preload("res://gui/alerts/JamError.tscn")
const TILESIZE = Vector2(16,16)

# Called when the node enters the scene tree for the first time.
func _ready():
	progress = lib.try_load(sfile,0)


func reset():
	_reg.clear()
	lookup.clear()
	time=0
func register(what:Node2D,layer:String,pos=null):
	if pos == null:
		pos=tile_pos(what.global_position)
	if layer in _reg:
		if pos in _reg[layer]:
			_reg[layer][pos].append(what)
		else:
			_reg[layer][pos]=[what]
	else:
		_reg[layer]={pos:[what]}
	if what in lookup:
		lookup[what].append([layer,pos])
	else:
		lookup[what]=[[layer,pos]]
	if not what.is_connected("tree_exiting",self,"unregister"):
		what.connect("tree_exiting",self,"unregister",[what],CONNECT_ONESHOT)
func deregister(what:Node2D,layer:String,pos:Vector2):
	_reg[layer][pos].erase(what)
	lookup[what].erase([layer,pos])
func find(layer:String,pos:Vector2)->Array:
	if layer in _reg:
		if pos in _reg[layer]:
			return _reg[layer][pos]
		return []
	return []
func all_pos(layer:String)->Array:
	if layer in _reg:
		return _reg[layer].keys()
	return []
func all_things(layer:String)->Array:
	var things=[]
	if layer in _reg:
		for t in _reg[layer].values():
			things+=t
	return things
func unregister(what:Node2D):
	assert(what in lookup)
	for lp in lookup[what]:
		_reg[lp[0]][lp[1]].erase(what)
	lookup.erase(what)
func jam(node:Node2D,custom=null):
	var new = (custom if custom else jam_error).instance()
	node.add_child(new)
	new.global_rotation=0
	errored=true
func _process(delta):
	if not errored:
		time+=delta
func tile_pos(pos:Vector2)->Vector2:
	return (pos/TILESIZE).snapped(Vector2.ONE)
func save_progress():
	progress=max(level,progress)
	lib.save(sfile,progress)
