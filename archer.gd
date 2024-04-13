extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var hp = 1
var spd = 220
var timervar = 0 # keps track of frames and allows state timing
signal stateChanged(newState)
var currState: int = archer.MOVE
var inRange = false
var relativeposition = Vector2()
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

func spawnArrow():
	add_child(load("res://archer_attack.tscn").instantiate())

#func _physics_process(delta):
#	if self.currState == archer.MOVE:
#		self.velocity = position.direction_to(target.position) * spd
#	move_and_slide()

func _physics_process(delta):
	relativeposition = target.position - position
	match currState:
		archer.MOVE:
			self.velocity = position.direction_to(target.position) * spd
			move_and_slide()
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else:
				$AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("move_L")
			if  inRange or timervar == 60:
				timervar = -1
				setState(archer.SHOOT)
			timervar += 1
		archer.SHOOT:
			if timervar == 0:
				spawnArrow()
			if timervar == 120:
				timervar = -1
				if !inRange:
					setState(archer.MOVE)
			timervar += 1
