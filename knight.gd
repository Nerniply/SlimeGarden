extends CharacterBody2D

var spd = -1
var hp = 0
var isCharging: bool
var timervar = 0
var currState: int = knight.WINDUP
signal stateChanged(newState)
var targetPosition #only updates during move

enum knight {
	WINDUP,
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

func collide(area: Area2D):
	if area.get_parent() is Player and currState != knight.CHARGE:
		queue_free()

func _physics_process(delta):
	if currState == knight.WINDUP:
		position += (targetPosition).normalized() * spd
		move_and_slide()
	elif currState == knight.CHARGE:
		position += (targetPosition).normalized() * spd
		move_and_slide()
	elif currState == knight.STUN
	
func _process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	match currState:
		knight.WINDUP:
			hp = 0
			spd = -1
			targetPosition = relativeposition
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("move_R")
			else: $AnimatedSprite2D.play("move_L")
			timervar += 1
			if  timervar >= 30:
				setState(knight.CHARGE)
				timervar = 0
		knight.CHARGE:
			hp = 5
			spd = 3.75
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("charge_R")
			else: $AnimatedSprite2D.play("charge_L")
		knight.STUN:
			hp = 0
			spd = 0
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("charge_R")
			else: $AnimatedSprite2D.play("charge_L")
