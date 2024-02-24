extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_node("Player").position + Vector2(36, 0).rotated(randf_range(0, 2*PI))

