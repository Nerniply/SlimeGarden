extends Node2D

var timer = 0
var animaterosa = "idle"
var animatewarrior = "idle_L"
var animatebaby = "idle"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimationPlayer.play("new_animation")
	$RosaPuppet.play(animaterosa)
	$Path2D/PathFollow2D/WarriorPuppet.play(animatewarrior)
	$Path2D2/PathFollow2D/BabyPuppet.play(animatebaby)
	if timer == 100:
		animaterosa = "Left"
	if timer == 150:
		$WarriorPanel.visible = true
	#if timer == 210:
		#$WarriorPanel.visible = false
	if timer == 240:
		$WarriorPanel.visible = false
		$RosaPuppet.flip_h = true
	if timer == 300:
		$RosaPuppet.flip_h = false
	if timer == 360:
		$SlimePanel.visible = true
	if timer == 420:
		$SlimePanel.visible = false
		$WarriorPanel2.visible = true
		animatewarrior = "move_L"
	if timer == 500:
		$WarriorPanel2.visible = false
	if timer == 505:
		$RosaPuppet.modulate = Color(1, 0, 0)
	if timer == 515:
		$RosaPuppet.modulate = Color(1, 1, 1)
	if timer == 564:
		$RosaPuppet.flip_h = true
	if timer == 570:
		animatebaby = "move_L"
	if timer == 660:
		animatebaby = "idle"
	if timer == 680:
		$SlimePanel2.visible = true
	if timer == 700:
		$SlimePanel2.visible = false
	if timer == 720:
		animatebaby = "move_L"
	if timer == 750:
		animatebaby = "idle"
		$Heal.play("heal")
	if timer == 770:
		animaterosa = "idle"
		$RosaPuppet.flip_h = false
	if timer == 900:
		get_tree().change_scene_to_file("res://game.tscn")
	timer += 1
