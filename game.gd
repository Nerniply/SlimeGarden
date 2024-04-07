extends Node2D

var ArrowEventTrigger = false
var ArrowTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_warrior_spawn_pressed():
	add_child(load("res://warrior.tscn").instantiate())


func _on_archer_spawn_pressed():
	add_child(load("res://archer.tscn").instantiate())
	ArrowEventTrigger = true


func _on_pyro_spawn_pressed():
	add_child(load("res://pyromancer.tscn").instantiate())
	add_child(load("res://pyro_event.tscn").instantiate())
	add_child(load("res://pyro_event.tscn").instantiate())
	add_child(load("res://pyro_event.tscn").instantiate())

func _on_knight_spawn_pressed():
	add_child(load("res://knight.tscn").instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if ArrowEventTrigger:
		if ArrowTimer % 15 == 0:
			add_child(load("res://archer_event.tscn").instantiate())
		if ArrowTimer == 180:
			ArrowTimer = -1
			ArrowEventTrigger = false
		ArrowTimer += 1
