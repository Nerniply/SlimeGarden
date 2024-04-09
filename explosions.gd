extends AnimatedSprite2D

var timervar = 0
var size
var hp = 1

func gethp():
	return hp

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(size, size)
	self.rotation = randf_range(0, 2*PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timervar += 1
	if timervar <= 50:
		self.play("warning")
	else: 
		self.play("explode")
		get_node("Boom1/CollisionShape2D").set_deferred("disabled", false)
		get_node("Boom2/CollisionShape2D").set_deferred("disabled", false)
		get_node("Boom3/CollisionShape2D").set_deferred("disabled", false)
	if timervar == 60:
		queue_free()
