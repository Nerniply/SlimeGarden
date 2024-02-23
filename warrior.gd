extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0




func _physics_process(delta):
	var target = get_parent().get_node("Rosa")
	position += (target.position - position).normalized() * 2

	move_and_slide()
