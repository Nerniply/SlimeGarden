extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
const spd = 140
const hp = 1
var direction = "X"
var relativeposition = Vector2()

func gethp():
	return hp

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		if (hp < area.get_parent().gethp()):
			queue_free()

func _physics_process(delta):
	relativeposition = target.position - position
	if relativeposition.x > 0:
		direction = "R"
	if relativeposition.x < 0:
		direction = "L"
	velocity = position.direction_to(target.position) * spd
	move_and_slide()

func _process(delta):
	if direction == "R":
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("move_L")
	if direction == "L":
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("move_L")
