extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text_cache:=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_text(text:String):
	text_cache.clear()
	$Label.text=""
	for c in text:
		text_cache.append(c)


func _on_Timer_timeout():
	while text_cache:
		var c=text_cache.pop_front()
		$Label.text+=c
		if c!=" ":
			break
