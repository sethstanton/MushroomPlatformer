extends State
class_name WalkingState

func enter():
	player.animated_sprite.play("Walk")

func physics_process(delta):
	var direction := Input.get_axis("Move_left", "Move_right")

	# Jump
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		player.current_state = JumpingState.new(player)
		player.current_state.enter()
		return

	# Fall
	if not player.is_on_floor():
		player.current_state = JumpingState.new(player)
		player.current_state.enter()
		return

	# Idle
	if direction == 0:
		player.current_state = IdleState.new(player)
		player.current_state.enter()
		return

	# Sprint
	if Input.is_action_pressed("Sprint"):
		player.current_state = SprintingState.new(player)
		player.current_state.enter()
		return

	# Flip sprite
	if direction > 0:
		player.animated_sprite.flip_h = false
	elif direction < 0:
		player.animated_sprite.flip_h = true

	player.velocity.x = direction * player.current_speed
	player.move_and_slide()
