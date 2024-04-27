extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var hp = 1
var spd = 220
var timervar = 0 # keps track of frames and allows state timing
signal stateChanged(newState)
var currState: int = archer.MOVE
var inRange = false
var relativeposition = Vector2()

func _ready():
		position = target.position + Vector2(735, 0).rotated(randf_range(0, 2*PI))


enum archer {
	MOVE,
	SHOOT,
	COOLDOWN
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
	if area.is_in_group("AscentTrigger"):
		self.set_collision_layer(16)
		self.set_collision_mask(16)
		self.z_index=3
		$Hitbox.set_collision_layer(16)
		$Hitbox.set_collision_mask(16)
	if area.is_in_group("DescentTrigger"):
		self.set_collision_layer(1)
		self.set_collision_mask(1)
		self.z_index=0
		$Hitbox.set_collision_layer(1)
		$Hitbox.set_collision_mask(1)
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

func _on_tree_entered():
	get_parent().currarchers += 1

func _on_tree_exiting():
	get_parent().currarchers -= 1

func _physics_process(delta):
	relativeposition = target.position - position
	if sqrt(relativeposition.x*relativeposition.x+relativeposition.y*relativeposition.y) >= 750:
		queue_free()
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
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else:
				$AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("shoot_L")
			if timervar == 0:
				spawnArrow()
			if timervar == 108:
				timervar = -1
				setState(archer.COOLDOWN)
			timervar += 1
		archer.COOLDOWN:
			if relativeposition.x > 0:
				$AnimatedSprite2D.flip_h = true # right
			else:
				$AnimatedSprite2D.flip_h = false # left
			$AnimatedSprite2D.play("idle_L")
			if timervar == 12:
				timervar = -1
				if !inRange:
					setState(archer.MOVE)
				else: setState(archer.SHOOT)
			timervar += 1
