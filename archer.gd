extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var hp = 1
var spd = 220
var timervar = 1 # keps track of frames and allows state timing
signal stateChanged(newState)
var currState: int = archer.MOVE
var inRange = false
var relativeposition = Vector2()

enum archer {
	MOVE,
	AIM,
	SHOOT
}

func gethp():
	return hp

# triggered by player entering detection range
func startShooting(area: Area2D) -> void:
	if (area.get_parent() is Player):
		inRange = true

# triggered by player exiting detection range
func startMoving(area: Area2D) -> void:
	if (area.get_parent() is Player):
		inRange = false

func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		if (hp < area.get_parent().gethp()):
			queue_free()

func setState(newState: int):
	if newState == currState:
		return
	currState = newState
	emit_signal("stateChanged", currState)

func spawnArrow():
	add_child(load("res://arrow.tscn").instantiate())

func _physics_process(delta):
	if self.currState == archer.MOVE:
		self.velocity = position.direction_to(target.position) * spd
	move_and_slide()

func _process(delta):
	relativeposition = target.position - position
	match currState:
		archer.MOVE:
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("move_L")
			else:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("move_L")
			if inRange:
				setState(archer.AIM)
		archer.AIM:
			if timervar == 0:
				spawnArrow()
		archer.SHOOT:
			if !inRange:
				setState(archer.MOVE)
	
