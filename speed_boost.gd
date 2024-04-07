extends Sprite2D
class_name SpeedBoost

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func collide(area: Area2D):
	if (area.get_parent() is Player):
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
