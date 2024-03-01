extends CharacterBody2D

var spd = 3
var hp = 1


func gethp():
	return hp

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = get_parent().get_node("AnimatedSprite2D").position + Vector2(0, -30)

func collide(area: Area2D):
	if area.is_in_group("Hitbox"):
		if area.get_parent() is Player or area.get_parent().get_parent() == self.get_parent():
			queue_free()
			get_parent().get_node("FireballIndicator").canDespawn = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	if get_parent().getShoot():
		velocity = position.direction_to(get_parent().getTarget()) * spd
		position += (get_parent().getTarget() + Vector2(0, 30)).normalized() * spd
		move_and_slide()

