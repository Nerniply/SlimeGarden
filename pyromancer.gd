extends CharacterBody2D

const spd = 1.5
const hp = 1
var inRange = false

func gethp():
	return hp

func startCasting(area: Area2D):
	if (area.get_parent() is Player):
		inRange = true

func startMoving(area: Area2D):
	if (area.get_parent() is Player):
		inRange = false

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		var playerhp = area.get_parent().gethp()
		if (hp < playerhp):
			queue_free()

func _physics_process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	if inRange:
		if relativeposition.x > 0:
			$AnimatedSprite2D.play("cast_R")
		else: $AnimatedSprite2D.play("cast_L")
	else:
		if relativeposition.x > 0:
			$AnimatedSprite2D.play("move_R")
		else: $AnimatedSprite2D.play("move_L")
		position += (target.position - position).normalized() * spd
		move_and_slide()

