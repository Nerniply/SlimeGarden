extends CharacterBody2D
class_name Health


@onready var target = get_parent().get_node("Rosa")
var spd = 50
var relativeposition = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().get_node("Rosa").position + Vector2(180, 0).rotated(randf_range(0, 2*PI))

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		queue_free()
	if area.is_in_group("AscentTrigger"):
		$Hitbox.set_collision_layer(16)
		$Hitbox.set_collision_mask(16)
		self.z_index=3
		self.set_collision_layer(16)
		self.set_collision_mask(16)
	if area.is_in_group("DescentTrigger"):
		self.set_collision_layer(1)
		self.set_collision_mask(1)
		self.z_index=0
		$Hitbox.set_collision_layer(1)
		$Hitbox.set_collision_mask(1)

func _physics_process(delta):
	relativeposition = target.position - position
	if relativeposition.x > 0:
		$AnimatedSprite2D.flip_h = false
	if relativeposition.x < 0:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("move_L")
	velocity = position.direction_to(target.position) * spd
	move_and_slide()
