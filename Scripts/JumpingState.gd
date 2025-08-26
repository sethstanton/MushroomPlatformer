extends State
class_name JumpingState

var air_control_factor := 0.9

func enter():
	player.velocity.y = player.JUMP_VELOCITY
	player.animated_sprite.play("Jump")

func physics_process(delta):
	var direction := Input.get_axis("Move_left", "Move_right")
	#print("Gravity: ", player.get_gravity_())
	#print("Velocity: ", player.velocity)


	# floor controls
	if player.is_on_floor():
		if Input.is_action_pressed("Sprint") and direction != 0:
			player.current_state = SprintingState.new(player)
		elif direction != 0:
			player.current_state = WalkingState.new(player)
		else:
			player.current_state = IdleState.new(player)
		player.current_state.enter()
		return
	
	
	# Mid-air horizontal control
	if not player.is_on_floor():
		player.velocity.y += player.get_gravity_() * delta
		player.velocity.x = direction * player.current_speed * air_control_factor

	if direction > 0:
		player.animated_sprite.flip_h = false
	elif direction < 0:
		player.animated_sprite.flip_h = true

	player.move_and_slide()
