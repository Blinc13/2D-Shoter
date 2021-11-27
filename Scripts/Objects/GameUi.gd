extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hero

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init(node):
	hero=node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text=str(hero.firePos)
