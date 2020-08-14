extends Node2D


export var gear = preload("res://components/gear/Gear.tscn")
var dragging:=false
var fpos: Vector2
var spos: Vector2
var tpos: Vector2
var place_mode = "gear"
var r = 0

func reset_crs():
	$CrosshairTL.position=Vector2(-8,-8)
	$CrosshairTR.position=Vector2(8,-8)
	$CrosshairBL.position=Vector2(-8,8)
	$CrosshairBR.position=Vector2(8,8)
# Called when the node enters the scene tree for the first time.
func _process(delta):
	tpos=registry.tile_pos(get_global_mouse_position())
	position=tpos*16
	$Arrow.rotation=TAU/4*r
	if dragging:
		tpos=inline_pos(tpos)
		$CrosshairTL.global_position=Vector2(min(tpos.x,fpos.x)*16-8,min(tpos.y,fpos.y)*16-8)
		$CrosshairTR.global_position=Vector2(max(tpos.x,fpos.x)*16+8,min(tpos.y,fpos.y)*16-8)
		$CrosshairBL.global_position=Vector2(min(tpos.x,fpos.x)*16-8,max(tpos.y,fpos.y)*16+8)
		$CrosshairBR.global_position=Vector2(max(tpos.x,fpos.x)*16+8,max(tpos.y,fpos.y)*16+8)

func _input(event):
	if event.is_action_pressed("rotate_left"):
		r-=1
		r%=4
	elif event.is_action_pressed("rotate_right"):
		r+=1
		r%=4
	elif event is InputEventMouseButton:
		if event.button_index==BUTTON_LEFT:
			if event.pressed:
				fpos=tpos
				dragging=true
			else:
				if dragging:
					spos=tpos
					place()
					reset_crs()
					dragging=false
func inline_pos(pos2):
	if abs(pos2.x-fpos.x)>abs(pos2.y-fpos.y):
		return Vector2(pos2.x,fpos.y)
	return Vector2(fpos.x,pos2.y)
func place():
	if spos==fpos:
		smart_place(gear,fpos)
	else:
		for p in lib.iterrow(fpos,inline_pos(spos)):
			smart_place(gear,p)
func smart_place(thing:PackedScene,tpos:Vector2):
	for b in registry.find("blocked",tpos):
		return
	var new = thing.instance()
	new.position=tpos*16
	get_parent().add_child(new)
