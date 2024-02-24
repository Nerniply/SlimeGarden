extends Node2D
class_name Health

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().get_node("Rosa").position + Vector2(108, 72).rotated(randf_range(0, 2*PI))

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		queue_free()
