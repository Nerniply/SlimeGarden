extends Node2D

@onready var player = get_parent().get_node("Rosa")
var hp = 1
var spd = 0
var timervar = 0
var targetDir

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func gethp():
	return hp

func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if area.get_parent().is_in_group("Solid"):
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if timervar < 60:
		look_at(player.global_position)
		targetDir = (player.global_position - self.global_position).normalized()
	else:
		self.spd = 2.7
		self.global_position += targetDir * spd
	timervar += 1
