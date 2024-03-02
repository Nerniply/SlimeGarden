extends CharacterBody2D

const spd = 3.75
const hp = 0
var isCharging: bool
var timervar = 0
var currState: int = knight.MOVE
signal stateChanged(newState)
var targetPosition #only updates during move

enum knight {
	MOVE,
	CHARGE,
	STUN,
}

func setState(newState: int):
	if newState == currState:
		return
	currState = newState
	emit_signal("stateChanged", currState)

func gethp():
	return hp

func playercollide(area: Area2D):
	if area.get_parent() is Player and !isCharging:
		queue_free()

func _physics_process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	if currState == knight.MOVE or currState == knight.CHARGE:
		position += (target.position - position).normalized() * spd
		move_and_slide()
	
func _process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	match currState:
		knight.MOVE:
			targetPosition = relativeposition
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("move_R")
			else: $AnimatedSprite2D.play("move_L")
			timervar += 1
			if  timervar >= 60:
				setState(knight.CHARGE)
		knight.CHARGE:
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("charge_R")
			else: $AnimatedSprite2D.play("charge_L")
		knight.STUN:
			pass
