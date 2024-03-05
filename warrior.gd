extends CharacterBody2D

const spd = 140
const hp = 1
var direction = "X"

func gethp():
	return hp

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		var playerhp = area.get_parent().gethp()
		if (hp < playerhp):
			queue_free()

func _physics_process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	velocity = position.direction_to(target.position) * spd
	if relativeposition.x > 0:
		direction = "R"
	if relativeposition.x < 0:
		direction = "L"
	move_and_slide()

func _process(delta):
	if direction == "R":
		$AnimatedSprite2D.play("move_R")
	if direction == "L":
		$AnimatedSprite2D.play("move_L")
