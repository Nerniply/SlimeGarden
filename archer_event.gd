extends Node2D

@onready var player = get_parent().get_node("Rosa")
var hp = 1
var spd = 2.7
var targetDirection

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = player.global_position + Vector2(0, 735).rotated(randf_range(0, 2*PI))
#	self.global_position = get_parent().get_parent().global_position
	look_at(player.global_position)
	targetDirection = (player.global_position - self.global_position).normalized()

func gethp():
	return hp

func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if area.get_parent().is_in_group("Solid"):
			get_parent().queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.global_position += targetDirection * spd
