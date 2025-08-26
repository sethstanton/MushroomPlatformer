extends CharacterBody2D

const JUMP_VELOCITY = -330.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var base_speed = 170
var current_speed = 170
var flat_speed_bonus = 0
var percentage_speed_bonus = 0
var sprint_multiplier = 1.4

var current_state: State
var fall_grace_timer := 0.2


func _ready():
	#print("ready function running")
	
	update_current_speed()
	var IdleStateScript = preload("res://Scripts/IdleState.gd")  # Adjust path!
	current_state = IdleStateScript.new(self)
	current_state.enter()

func _physics_process(delta: float) -> void:
	if fall_grace_timer > 0:
		fall_grace_timer -= delta

	update_current_speed()
	current_state.physics_process(delta)

func update_current_speed() -> void:
	current_speed = base_speed + flat_speed_bonus + (base_speed * percentage_speed_bonus)

func get_gravity_():
	return ProjectSettings.get_setting("physics/2d/default_gravity")
