extends AnimatedSprite2D
class_name SpeedBoost

var cooldowntimer = 18000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func collide(area: Area2D):
	if (area.get_parent() is Player):
		if !area.get_parent().spdup:
			self.hide()
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			cooldowntimer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	play("default")
	if cooldowntimer < 18000:
		cooldowntimer += 1
		if cooldowntimer == 18000:
			self.show()
			$Area2D/CollisionShape2D.set_deferred("disabled", false)
	else: pass
