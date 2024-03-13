extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var hp = 1
var spd = 220
var timervar = 1 # keps track of frames and allows state timing
signal stateChanged(newState)
var input = Vector2()
var currState: int = archer.MOVE
var inRange = false

enum archer {
	MOVE,
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

func _physics_process(delta):
	if currState == archer.MOVE:
		velocity = position.direction_to(target.position) * spd
		move_and_slide()

func _process(delta):
	input = Vector2()
	match currState:
		archer.MOVE:
			if inRange:
				setState(archer.SHOOT)
		archer.SHOOT:
			if !inRange:
				setState(archer.MOVE)
	
