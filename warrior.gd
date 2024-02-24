extends CharacterBody2D
class_name Enemy

const spd = 7
const hp = 1



func warriorcollide(warriorHitbox):
	self.queue_free()

func _physics_process(delta):
	var target = get_parent().get_node("Rosa")
	position += (target.position - position).normalized() * spd
	move_and_slide()

