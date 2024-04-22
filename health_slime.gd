extends CharacterBody2D
class_name Health


@onready var target = get_parent().get_node("Rosa")
var spd = 100
var relativeposition = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().get_node("Rosa").position + Vector2(108, 72).rotated(randf_range(0, 2*PI))

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		queue_free()

func _physics_process(delta):
	relativeposition = target.position - position
	if relativeposition.x > 0:
		$AnimatedSprite2D.flip_h = false
	if relativeposition.x < 0:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("move_L")
	velocity = position.direction_to(target.position) * spd
	move_and_slide()
