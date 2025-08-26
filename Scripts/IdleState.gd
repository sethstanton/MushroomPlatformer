extends State
class_name IdleState

func enter():
	player.animated_sprite.play("Idle")

func physics_process(delta):
	#if player.is_on_floor:
		#print("Is on floor", player.is_on_floor())
	
	var direction := Input.get_axis("Move_left", "Move_right")

	# Jump
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		player.current_state = JumpingState.new(player)
		player.current_state.enter()
		print("Idle Jump")
		return
	
	if not player.is_on_floor() and player.fall_grace_timer <= 0:
		player.current_state = JumpingState.new(player)
		player.current_state.enter()
		print("idle fall")
		return

	# Sprint
	if Input.is_action_pressed("Sprint") and direction != 0:
		player.current_state = SprintingState.new(player)
		player.current_state.enter()
		return

	# Walk
	if direction != 0:
		player.current_state = WalkingState.new(player)
		player.current_state.enter()
		return

	player.velocity.x = direction * player.current_speed
	player.move_and_slide()
