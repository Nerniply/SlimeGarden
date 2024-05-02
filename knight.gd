extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var chargespd = 0 # spd = 0
var hp = 5
var spd = 1000 # chargespd = 1000
var timervar = 0
var currState: int = knight.WINDUP
signal stateChanged(newState)
var targetPosition # only updates during windup
var relativeposition
var startposition # only updates during windup

func _ready():
	# Spawning distance - accounts for viewport size and camera zoom
	position = target.position + Vector2(get_viewport().size.x/(2*target.get_node("PlayerCam").get_zoom().x), get_viewport().size.y/(2*target.get_node("PlayerCam").get_zoom().y)).rotated(randf_range(0, 2*PI))
	#position = target.position + Vector2(735, 0).rotated(randf_range(0, 2*PI))


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

func _on_VisibilityNotifier2D_screen_exited():
	if currState == knight.CHARGE:
		setState(knight.STUN)

func collide(area: Area2D):
	#if area.is_in_group("SlowTrigger"):
		#chargespd /= 2
	if currState == knight.CHARGE:
		if area.get_parent().is_in_group("Wall"):
			setState(knight.STUN)
	else:
		if area.get_parent() is Player:
			queue_free()

#func exit(area: Area2D):
	#if area.is_in_group("SlowTrigger"):
		#chargespd *= 2

func _on_tree_entered():
	get_parent().currknight += 1

func _on_tree_exiting():
	get_parent().currknight -= 1

func _physics_process(delta):
	#relativeposition = target.position - position
	match currState:
		knight.WINDUP:
			hp = 5
			chargespd = 0 # spd = 0
			targetPosition = target.position
			startposition = self.position
			relativeposition = targetPosition - startposition
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
			chargespd = spd # spd = chargespd
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("charge_L2")
			velocity = startposition.direction_to(targetPosition) * chargespd # spd
			move_and_slide()
		knight.STUN:
			hp = 0
			if timervar < 10:
				chargespd = -(spd/10) # spd = -(chargespd/10)
			else: chargespd = 0 # spd = 0
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("stun_L")
			velocity = startposition.direction_to(targetPosition) * chargespd # spd
			move_and_slide()
			if timervar == 210: # ~3.5 sec
				setState(knight.WINDUP)
				timervar = -1
			timervar += 1
				
