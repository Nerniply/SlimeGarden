extends CharacterBody2D

const spd = 1.5
const hp = 1
var inRange = false
var timervar = 1
var currState: int = pyro.MOVE
signal stateChanged(newState)
var targetPosition
var readyToShoot

enum pyro {
	MOVE,
	TARGET,
	CAST,
	COOLDOWN
}

func setState(newState: int):
	if newState == currState:
		return
	currState = newState
	emit_signal("stateChanged", currState)

func gethp():
	return hp

func getTarget():
	return targetPosition

func getShoot():
	return readyToShoot

func startCasting(area: Area2D) -> void:
	if (area.get_parent() is Player):
		if currState == pyro.MOVE:
			# print("changing state: TARGET")
			setState(pyro.TARGET)
		inRange = true

func startMoving(area: Area2D) -> void:
	if (area.get_parent() is Player):
		inRange = false

# detects when pyromancer collides with player
func playercollide(area: Area2D):
	if (area.get_parent() is Player):
		var playerhp = area.get_parent().gethp()
		if (hp < playerhp):
			queue_free()

# spawns a new fireball
func spawnfireball():
	add_child(load("res://fireball.tscn").instantiate())
	add_child(load("res://fireball_indicator.tscn").instantiate())

func _physics_process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	if currState == pyro.MOVE:
		position += (target.position - position).normalized() * spd
		move_and_slide()

func _process(delta):
	var target = get_parent().get_node("Rosa")
	var relativeposition = target.position - position
	match currState:
		pyro.MOVE:
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("move_R")
			else: $AnimatedSprite2D.play("move_L")
		pyro.TARGET:
			targetPosition = relativeposition # for giving firball indicator a location
			readyToShoot = false
			if timervar == 1:
				spawnfireball()
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("idle_R")
			else: $AnimatedSprite2D.play("idle_L")
			timervar += 1
			if timervar == 120: # time spent in this state (~2 sec)
				timervar = 1
				# print("changing state: CAST")
				setState(pyro.CAST)
		pyro.CAST:
			readyToShoot = true
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("cast_R")
			else: $AnimatedSprite2D.play("cast_L")
			if $AnimatedSprite2D.get_frame() == 6 and $AnimatedSprite2D.get_frame_progress() > 0.92: # on the next frame the animation will loop
				# print("changing state: COOLDOWN")
				setState(pyro.COOLDOWN)
		pyro.COOLDOWN:
			if relativeposition.x > 0:
				$AnimatedSprite2D.play("idle_R")
			else: $AnimatedSprite2D.play("idle_L")
			timervar += 1
			if timervar == 120: # time spent in this state (~2 sec)
				timervar = 1
				if inRange:
					# print("changing state: TARGET")
					setState(pyro.TARGET)
				else:
					# print("changing state: MOVE")
					setState(pyro.MOVE)
