extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text_cache:=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_text(text:String):
	$Label.text=""
	for c in text:
		text_cache.append(c)


func _on_Timer_timeout():
	if text_cache:
		$Label.text+=text_cache.pop_front()
