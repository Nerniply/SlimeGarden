extends CharacterBody2D
class_name Health

@onready var isactive = false
@onready var mama = get_parent().get_node("Rosa")
@onready var ejecttoward = mama.position + Vector2(350, 0).rotated(randf_range(0, 2*PI))
@onready var lifetimer = 0
@onready var ejecttimer = 0
var spd = 50
var ejectspd = 200
var relativeposition = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#position = get_parent().get_node("Rosa").position + Vector2(180, 0).rotated(randf_range(0, 2*PI))
	position = get_parent().get_node("Rosa").position

func playercollide(area: Area2D):
	if (area.get_parent() is Player) and self.isactive:
		queue_free()
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

func _physics_process(delta):
	relativeposition = mama.position - position
	if relativeposition.x > 0:
		$AnimatedSprite2D.flip_h = false
	if relativeposition.x < 0:
		$AnimatedSprite2D.flip_h = true
		#$AnimatedSprite2D.play(animation)
		
	if !isactive:
		$AnimatedSprite2D.play("spawn")
		if relativeposition.x > 0:
			$AnimatedSprite2D.flip_h = true
		if relativeposition.x < 0:
			$AnimatedSprite2D.flip_h = false
		velocity = position.direction_to(ejecttoward) * ejectspd
		ejecttimer += 1
		if ejecttimer == 24:
			ejectspd = 0
		if ejecttimer == 54:
			isactive = true
	else:
		$AnimatedSprite2D.play("move_L")
		velocity = position.direction_to(mama.position) * spd
		if lifetimer == 600:
			queue_free()
		else: lifetimer += 1
	move_and_slide()
