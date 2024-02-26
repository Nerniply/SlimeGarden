extends CharacterBody2D

const spd = 3.5
const hp = 1

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
	if relativeposition.x > 0:
		$AnimatedSprite2D.play("move_R")
	else: $AnimatedSprite2D.play("move_L")
	#position += (relativeposition).normalized() * spd
	#move_and_slide()

