extends Sprite2D

var timervar = 0
var size
var hp = 1

func gethp():
	return hp

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(size, size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timervar += 1
	if timervar == 10:
		queue_free()
