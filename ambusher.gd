extends CharacterBody2D

@onready var target = get_parent().get_parent().get_node("Rosa")
var spd = 0
var hp = 1
var relativeposition = Vector2()

func _ready():
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	get_parent().triggered.connect(trigger)

func gethp():
	return hp

func trigger(triggered: bool):
	spd = 190
	self.show()
	$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	$CollisionShape2D.set_deferred("disabled", false)

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		if (hp < area.get_parent().gethp()):
			queue_free()

func _physics_process(delta):
	#self.target = get_parent().target
	relativeposition = target.position - global_position
	if relativeposition.x > 0:
		$AnimatedSprite2D.flip_h = true
	if relativeposition.x < 0:
		$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("move_L")
	velocity = global_position.direction_to(target.position) * spd
	move_and_slide()


