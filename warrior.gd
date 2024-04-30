extends CharacterBody2D

@onready var target = get_parent().get_node("Rosa")
var spd = 220
const hp = 1
var relativeposition = Vector2()
var distancecalc
#var spawnhelper
#var northhelper
#var easthelper
#var southhelper
#var westhelper

func _ready():
	# 735 = distance to corner of screen from center
	#spawnhelper = get_parent().get_node("Rosa").position
	#northhelper = get_parent().get_node("NorthWall").position.y - spawnhelper.y # y distance from player to north wall (will be -)
	#easthelper = get_parent().get_node("EastWall").position.x - spawnhelper.x # x distance from player to east wall (will be +)
	#southhelper = get_parent().get_node("SouthWall").position.y - spawnhelper.y # y distance from player to south wall (will be +)
	#westhelper = get_parent().get_node("WestWall").position.x - spawnhelper.x # x distance from player to west wall (will be -)
	#if spawnhelper.x > get_parent().get_node("EastWall").position.x - 745:
		#var eangle = acos((easthelper-10)/735) # angle of 735 radius circle intersecting east wall
		#if spawnhelper.y > get_parent().get_node("SouthWall").position.y - 745:
			#var sangle = acos((southhelper - 10)/735) # angle of 735 radius circle intersecting south wall
			#position = spawnhelper + Vector2(-sqrt(735*735-(southhelper-10)*(southhelper-10)), southhelper - 10).rotated(randf_range(0, 1.5*PI-(eangle+sangle)))
		#elif spawnhelper.y < get_parent().get_node("NorthWall").position.y + 745:
			#var nangle = acos(-(northhelper + 10)/735) # angle of 735 radius circle intersecting north wall
			#position = spawnhelper + Vector2(easthelper - 10, sqrt(735*735-(easthelper-10)*(easthelper-10))).rotated(randf_range(0, 1.5*PI-(eangle+nangle)))
		#else: position = spawnhelper + Vector2(easthelper - 10, sqrt(735*735-(easthelper-10)*(easthelper-10))).rotated(randf_range(0, 2*PI-(2*eangle)))
	#elif spawnhelper.x < get_parent().get_node("WestWall").position.x + 745:
		#var wangle = acos(-(westhelper+10)/735) # angle of 735 radius circle intersecting west wall
		#if spawnhelper.y > get_parent().get_node("SouthWall").position.y - 745:
			#var sangle = acos((southhelper - 10)/735) # angle of 735 radius circle intersecting south wall
			#position = spawnhelper + Vector2(westhelper + 10, -sqrt(735*735-(westhelper+10)*(westhelper+10))).rotated(randf_range(0, 1.5*PI-(wangle+sangle)))
		#elif spawnhelper.y < get_parent().get_node("NorthWall").position.y + 745:
			#var nangle = acos(-(northhelper + 10)/735) # angle of 735 radius circle intersecting north wall
			#position = spawnhelper + Vector2(sqrt(735*735-(northhelper+10)*(northhelper+10)), northhelper + 10).rotated(randf_range(0, 1.5*PI-(wangle+nangle)))
		#else: position = spawnhelper + Vector2(westhelper + 10, -sqrt(735*735-(westhelper+10)*(westhelper+10))).rotated(randf_range(0, 2*PI-(2*wangle)))
	#else: 
		#if spawnhelper.y > get_parent().get_node("SouthWall").position.y - 745:
			#var sangle = acos((southhelper - 10)/735) # angle of 735 radius circle intersecting south wall
			#position = spawnhelper + Vector2(-sqrt(735*735-(southhelper-10)*(southhelper-10)), southhelper - 10).rotated(randf_range(0, 2*PI-(2*sangle)))
		#elif spawnhelper.y < get_parent().get_node("NorthWall").position.y + 745:
			#var nangle = acos(-(northhelper + 10)/735) # angle of 735 radius circle intersecting north wall
			#position = spawnhelper + Vector2(sqrt(735*735-(northhelper+10)*(northhelper+10)), northhelper + 10).rotated(randf_range(0, 2*PI-(2*nangle)))
		#else: 
	position = target.position + Vector2(get_viewport().size.x/(2*target.get_node("PlayerCam").get_zoom().x), get_viewport().size.y/(2*target.get_node("PlayerCam").get_zoom().y)).rotated(randf_range(0, 2*PI))
	#position = target.position + Vector2(735,0).rotated(randf_range(0, 2*PI))

func gethp():
	return hp

func playercollide(area: Area2D):
	if area.is_in_group("AscentTrigger"):
		$Hitbox.set_collision_layer(16)
		$Hitbox.set_collision_mask(16)
		self.z_index=3
		self.set_collision_layer(16)
		self.set_collision_mask(16)
	if area.is_in_group("DescentTrigger"):
		self.set_collision_layer(1)
		self.set_collision_mask(1)
		self.z_index=0
		$Hitbox.set_collision_layer(1)
		$Hitbox.set_collision_mask(1)
	if (area.get_parent() is Player):
		if (hp < area.get_parent().gethp()):
			queue_free()

func _on_tree_entered():
	get_parent().currwarriors += 1

func _on_tree_exiting():
	get_parent().currwarriors -= 1

func _physics_process(delta):
	distancecalc = sqrt((get_viewport().size.x/(2*target.get_node("PlayerCam").get_zoom().x))*(get_viewport().size.x/(2*target.get_node("PlayerCam").get_zoom().x))+(get_viewport().size.y/(2*target.get_node("PlayerCam").get_zoom().y))*(get_viewport().size.y/(2*target.get_node("PlayerCam").get_zoom().y)))
	relativeposition = target.position - position
	if sqrt(relativeposition.x*relativeposition.x+relativeposition.y*relativeposition.y) >= distancecalc + 30:
		queue_free()
	if relativeposition.x > 0:
		$AnimatedSprite2D.flip_h = true
	if relativeposition.x < 0:
		$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("move_L")
	velocity = position.direction_to(target.position) * spd
	move_and_slide()
