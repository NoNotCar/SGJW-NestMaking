extends Node2D


export var gear = preload("res://components/gear/Gear.tscn")
export var axle = preload("res://components/axle/Axle.tscn")
export var bevel = preload("res://components/bevel/Bevel.tscn")
export var sbevel = preload("res://components/bevel/SmallBevel.tscn")
export var belt = preload("res://components/belt/Belt.tscn")
export var diff = preload("res://components/differential/Differential.tscn")
export var cross = preload("res://components/crossaxle/Crossover.tscn")

var dragging:=false
var fpos: Vector2
var spos: Vector2
var tpos: Vector2
var r = 0
var simpledict = {"gear":gear, "axle": axle,"differential":diff,"crossover":cross}
var bdict = {"bevel":bevel, "smallbevel":sbevel}
var spawndict = {}

func reset_crs():
	$CrosshairTL.position=Vector2(-8,-8)
	$CrosshairTR.position=Vector2(8,-8)
	$CrosshairBL.position=Vector2(-8,8)
	$CrosshairBR.position=Vector2(8,8)
	$Arrow.position=Vector2.ZERO
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
		$Arrow.global_position=tpos*16
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if tpos in spawndict and spawndict[tpos]:
			spawndict[tpos].queue_free()

func _input(event):
	if get_parent().running:
		return
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
	var placing=registry.placing
	if spos==fpos:
		if placing in simpledict:
			smart_place(simpledict[placing],fpos)
		else:
			match placing:
				"bevel":
					smart_place(bevel,fpos)
				"smallbevel":
					smart_place(sbevel,fpos)
				"belt":
					smart_place(belt,fpos,1)
	else:
		var ipos=inline_pos(spos)
		r=int(lib.rpoint(ipos-fpos)/(PI/2))%4
		if placing in simpledict:
			var d=0.0
			for p in lib.iterrow(fpos,inline_pos(spos)):
				$Delay.interpolate_callback(self,d,"smart_place",simpledict[placing],p)
				d+=0.05
			$Delay.start()
		else:
			if placing in bdict:
				var d=0.0
				for p in lib.iterrow(fpos,ipos):
					$Delay.interpolate_callback(self,d,"smart_place",bdict[placing] if p==ipos else axle,p)
					d+=0.05
				$Delay.start()
			else:
				for p in lib.iterrow(fpos,ipos):
					for b in registry.find("blocked",p):
						return
				var new = belt.instance()
				new.position=Vector2(min(fpos.x,ipos.x),min(fpos.y,ipos.y))*16
				new.rotation=0.0 if ipos.y==fpos.y else PI/2
				new.length=(ipos-fpos).length()+1
				get_parent().add_child(new)
				$PlaceSound.play()
				for p in lib.iterrow(fpos,ipos):
					spawndict[p]=new
func smart_place(thing:PackedScene,pos:Vector2,ex_r=0):
	for b in registry.find("blocked",pos):
		return
	if abs(tpos.x)>get_parent().size.x or abs(pos.y)>get_parent().size.y:
		return
	var new = thing.instance()
	new.position=pos*16
	new.rotation=(r+ex_r)%4*TAU/4
	get_parent().add_child(new)
	spawndict[pos]=new
	$PlaceSound.play()
