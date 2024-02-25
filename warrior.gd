extends CharacterBody2D

const spd = 7
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
	position += (target.position - position).normalized() * spd
	move_and_slide()

