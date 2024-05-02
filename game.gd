extends Node2D
@onready var currState = 1

var ArrowsReady = true
var ArrowEventTrigger = false
var ArrowPassageTrigger = false
var ArrowTimer = 0
var ArrowDir = 1
var PyroEventTrigger = false
var PyroEventTimer = 0
var currwarriors = 0
var maxwarriors = 0
var currarchers = 0
var maxarchers = 0
var currpyro = 0
var maxpyro = 0
var currknight = 0
var maxknight = 0


#var enabledamount = 4
#var randspawn
#var count = 0
#func get_spawn():
	#var output
	#count = 0
	#randspawn = randi_range(1, enabledamount)
	##print(enabledamount)
	##print(randspawn)
	#if !$Rosa/SpawnArea1.enabled and count != randspawn:
		#count += 1
		#if count == randspawn:
			#output = $Rosa/SpawnArea1.global_position
	#if !$Rosa/SpawnArea2.enabled and count != randspawn:
		#count += 1
		#if count == randspawn:
			#output = $Rosa/SpawnArea2.global_position
	#if !$Rosa/SpawnArea3.enabled and count != randspawn:
		#count += 1
		#if count == randspawn:
			#output = $Rosa/SpawnArea3.global_position
	#if !$Rosa/SpawnArea4.enabled and count != randspawn:
		#count += 1
		#if count == randspawn:
			#output = $Rosa/SpawnArea4.global_position
	

#enum gamephase {
	#MOVE,
	#TARGET,
	#CAST,
	#COOLDOWN
#}



func setState(newState: int):
	if newState == currState:
		return
	currState = newState
	emit_signal("stateChanged", currState)

# Called when the node enters the scene tree for the first time.
func _ready():
	#$CanvasLayer/HealthHearts.updateMaxHP(10)
	pass

func _on_arrow_passage_area_entered(area):
	if area.get_parent() is Player:
		ArrowPassageTrigger = true

func _on_arrow_passage_area_exited(area):
	if area.get_parent() is Player:
		ArrowPassageTrigger = false
		ArrowTimer == -1

func _on_warrior_spawn_pressed():
	add_child(load("res://warrior.tscn").instantiate())
func _on_archer_spawn_pressed():
	add_child(load("res://archer.tscn").instantiate())
func _on_pyro_spawn_pressed():
	add_child(load("res://pyromancer.tscn").instantiate())
func _on_knight_spawn_pressed():
	add_child(load("res://knight.tscn").instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$CanvasLayer/HealthHearts.updateCurHP($Rosa.curhp)
	#$CanvasLayer/healthtxt.text = str($Rosa.curhp)
	#$CanvasLayer/healthbar.max_value = $Rosa.maxhp
	#$CanvasLayer/healthbar.value = $Rosa.curhp
	
	
	
	# triggered on forest phase change and forever after
	if ArrowEventTrigger and ArrowsReady:
		if ArrowTimer % 5 == 0:
			add_child(load("res://archer_event.tscn").instantiate())
			ArrowDir *= -1
		if ArrowTimer == 180:
			ArrowTimer = -1
			ArrowsReady = false
		ArrowTimer += 1
	elif !ArrowsReady:
		if ArrowTimer == 900:
			ArrowTimer = -1
			ArrowsReady = true
		ArrowTimer += 1
	
	# triggered on area entered
	if ArrowPassageTrigger:
		if ArrowTimer == 5:
			add_child(load("res://archer_event.tscn").instantiate())
			ArrowDir *= -1
			ArrowTimer = 0
		ArrowTimer += 1
	
	if PyroEventTrigger:
		if PyroEventTimer == 1200:
			add_child(load("res://pyro_event.tscn").instantiate())
			add_child(load("res://pyro_event.tscn").instantiate())
			add_child(load("res://pyro_event.tscn").instantiate())
			PyroEventTimer = -1
		PyroEventTimer += 1
	
	
	#checks how many of each enemy exist and spawns one if there are less then maximum
	if currwarriors < maxwarriors:
		add_child(load("res://warrior.tscn").instantiate())
	if currarchers < maxarchers:
		add_child(load("res://archer.tscn").instantiate())
	if currpyro < maxpyro:
		add_child(load("res://pyromancer.tscn").instantiate())
	if currknight < maxknight:
		add_child(load("res://knight.tscn").instantiate())
	
	# controls the phase of the game (and how many enemies there are)
	match currState:
		1:
			maxwarriors = 3
		2:
			maxwarriors = 4
			maxarchers = 2
		3:
			maxwarriors = 6
			maxarchers = 4
			maxpyro = 2
		4:
			maxwarriors = 12
			maxarchers = 8
			maxpyro = 4
			maxknight = 1

func _on_forest_trigger_area_entered(area):
	if area.get_parent() is Player:
		currState += 1
		ArrowEventTrigger = true
		$Rosa.maxhp -= 5
		$CanvasLayer/HealthHearts.updateMaxHP($Rosa.maxhp)
		$Forest.queue_free()
		$Walls/Forest/StaticBody2D/TempTreeWall.queue_free()
		$Dirt.queue_free()

func _on_cave_trigger_area_entered(area):
	if area.get_parent() is Player:
		currState += 1
		add_child(load("res://pyro_event.tscn").instantiate())
		add_child(load("res://pyro_event.tscn").instantiate())
		add_child(load("res://pyro_event.tscn").instantiate())
		PyroEventTimer = true
		$Rosa.maxhp -= 5
		$CanvasLayer/HealthHearts.updateMaxHP($Rosa.maxhp)
		$Walls/TempCaveBridge.queue_free()
		$SunStone.queue_free()
		$ExitBridge.show()

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		currState += 1
		$Rosa.maxhp -= 5
		$CanvasLayer/HealthHearts.updateMaxHP($Rosa.maxhp)
		$Water.queue_free()
