extends Sprite2D

var timervar = 0
var size
var hp = 3
var explosions = preload("res://explosions.tscn").instantiate()

func gethp():
	return hp

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(size, size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play("default")
	if timervar == 0:
		explosions.position = self.position
		explosions.size = self.size
		#get_parent().add_child(explosions)
	elif timervar == 71:
		queue_free()
	timervar += 1
