extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var spd = 0
var hp = 5
var stunspd
var isCharging: bool
var timervar = 0
var currState: int = knight.WINDUP
signal stateChanged(newState)
var targetPosition # only updates during windup
var relativeposition
var startposition # only updates during windup

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
	if currState == knight.CHARGE:
		if area.get_parent().is_in_group("Wall"):
			setState(knight.STUN)
	else:
		if area.get_parent() is Player:
			queue_free()

func wallExit(area: Area2D):
	pass

func _physics_process(delta):
	#relativeposition = target.position - position
	match currState:
		knight.WINDUP:
			hp = 5
			spd = 0
			relativeposition = target.position - self.position
			targetPosition = target.position
			startposition = self.position
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("windup_L2")
			if  timervar == 180:
				setState(knight.CHARGE)
				timervar = -1
			timervar += 1
		knight.CHARGE:
			hp = 5
			spd = 250
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("charge_L2")
			velocity = startposition.direction_to(targetPosition) * spd
			move_and_slide()
		knight.STUN:
			hp = 0
			if timervar < 10:
				spd = -25
			else: spd = 0
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("stun_L")
			velocity = startposition.direction_to(targetPosition) * spd
			move_and_slide()
			if timervar == 90:
				setState(knight.WINDUP)
				timervar = -1
			timervar += 1
				
