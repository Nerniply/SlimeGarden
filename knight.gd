extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var spd = 0
var hp = 5
var chargespd = 1000
var timervar = 0
var currState: int = knight.WINDUP
signal stateChanged(newState)
var targetPosition # only updates during windup
var relativeposition
var startposition # only updates during windup
var spawnhelper
var northhelper
var easthelper
var southhelper
var westhelper

func _ready():
	# 735 = distance to corner of screen from center
	spawnhelper = get_parent().get_node("Rosa").position
	northhelper = get_parent().get_node("NorthWall").position.y - spawnhelper.y # y distance from player to north wall (will be -)
	easthelper = get_parent().get_node("EastWall").position.x - spawnhelper.x # x distance from player to east wall (will be +)
	southhelper = get_parent().get_node("SouthWall").position.y - spawnhelper.y # y distance from player to south wall (will be +)
	westhelper = get_parent().get_node("WestWall").position.x - spawnhelper.x # x distance from player to west wall (will be -)
	if spawnhelper.x > get_parent().get_node("EastWall").position.x - 745:
		var eangle = acos((easthelper-10)/735) # angle of 735 radius circle intersecting east wall
		if spawnhelper.y > get_parent().get_node("SouthWall").position.y - 745:
			var sangle = acos((southhelper - 10)/735) # angle of 735 radius circle intersecting south wall
			position = spawnhelper + Vector2(-sqrt(735*735-(southhelper-10)*(southhelper-10)), southhelper - 10).rotated(randf_range(0, 1.5*PI-(eangle+sangle)))
		elif spawnhelper.y < get_parent().get_node("NorthWall").position.y + 745:
			var nangle = acos(-(northhelper + 10)/735) # angle of 735 radius circle intersecting north wall
			position = spawnhelper + Vector2(easthelper - 10, sqrt(735*735-(easthelper-10)*(easthelper-10))).rotated(randf_range(0, 1.5*PI-(eangle+nangle)))
		else: position = spawnhelper + Vector2(easthelper - 10, sqrt(735*735-(easthelper-10)*(easthelper-10))).rotated(randf_range(0, 2*PI-(2*eangle)))
	elif spawnhelper.x < get_parent().get_node("WestWall").position.x + 745:
		var wangle = acos(-(westhelper+10)/735) # angle of 735 radius circle intersecting west wall
		if spawnhelper.y > get_parent().get_node("SouthWall").position.y - 745:
			var sangle = acos((southhelper - 10)/735) # angle of 735 radius circle intersecting south wall
			position = spawnhelper + Vector2(westhelper + 10, -sqrt(735*735-(westhelper+10)*(westhelper+10))).rotated(randf_range(0, 1.5*PI-(wangle+sangle)))
		elif spawnhelper.y < get_parent().get_node("NorthWall").position.y + 745:
			var nangle = acos(-(northhelper + 10)/735) # angle of 735 radius circle intersecting north wall
			position = spawnhelper + Vector2(sqrt(735*735-(northhelper+10)*(northhelper+10)), northhelper + 10).rotated(randf_range(0, 1.5*PI-(wangle+nangle)))
		else: position = spawnhelper + Vector2(westhelper + 10, -sqrt(735*735-(westhelper+10)*(westhelper+10))).rotated(randf_range(0, 2*PI-(2*wangle)))
	else: 
		if spawnhelper.y > get_parent().get_node("SouthWall").position.y - 745:
			var sangle = acos((southhelper - 10)/735) # angle of 735 radius circle intersecting south wall
			position = spawnhelper + Vector2(-sqrt(735*735-(southhelper-10)*(southhelper-10)), southhelper - 10).rotated(randf_range(0, 2*PI-(2*sangle)))
		elif spawnhelper.y < get_parent().get_node("NorthWall").position.y + 745:
			var nangle = acos(-(northhelper + 10)/735) # angle of 735 radius circle intersecting north wall
			position = spawnhelper + Vector2(sqrt(735*735-(northhelper+10)*(northhelper+10)), northhelper + 10).rotated(randf_range(0, 2*PI-(2*nangle)))
		else: position = spawnhelper + Vector2(735, 0).rotated(randf_range(0, 2*PI))


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
	if currState == knight.CHARGE:
		if area.get_parent().is_in_group("Wall"):
			setState(knight.STUN)
	else:
		if area.get_parent() is Player:
			queue_free()

func _on_tree_entered():
	get_parent().currknight += 1

func _on_tree_exiting():
	get_parent().currknight -= 1

func _physics_process(delta):
	print(self.position)
	#relativeposition = target.position - position
	match currState:
		knight.WINDUP:
			hp = 5
			spd = 0
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
			spd = chargespd
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("charge_L2")
			velocity = startposition.direction_to(targetPosition) * spd
			move_and_slide()
		knight.STUN:
			hp = 0
			if timervar < 10:
				spd = -(chargespd/10)
			else: spd = 0
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else: $AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("stun_L")
			velocity = startposition.direction_to(targetPosition) * spd
			move_and_slide()
			if timervar == 210: # ~3.5 sec
				setState(knight.WINDUP)
				timervar = -1
			timervar += 1
				
