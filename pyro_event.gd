extends Node2D
@onready var player = get_parent().get_node("Rosa")
var explosion = preload("res://explosion.tscn").instantiate()
var timervar = 0 #

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = Vector2(player.position.x + randf_range(-640,640), player.position.y + randf_range(-360, 360))
	explosion.position = self.position
	explosion.size = 5
#	explosion.rotated(randf_range(0, 2*PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	position = get_parent().getTarget()


func _physics_process(delta):
	if timervar == 60: #
		get_parent().add_child(explosion)
		queue_free()
	timervar += 1
