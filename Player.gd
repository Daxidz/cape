extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

onready var cloak = get_node("Sprite/Base")

func _ready():
	$AnimationPlayer.play("run")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	var pos = position
	var new_pos
	velocity = move_and_slide(velocity)
	new_pos = position

	if velocity.x > 0.0:
		$Sprite.flip_h = false
		cloak.current_idx = cloak.IDX_MODES.RIGHT
	elif velocity.x < 0.0:
		$Sprite.flip_h = true
		cloak.current_idx = cloak.IDX_MODES.LEFT
	elif velocity.y > 0.0:
		cloak.current_idx = cloak.IDX_MODES.DOWN
	elif velocity.y < 0.0:
		cloak.current_idx = cloak.IDX_MODES.UP
	else:
		cloak.current_idx = cloak.IDX_MODES.IDLE
		

#	$Cape/Base.position += pos-new_pos
	#$Cape/Base.position = pos-new_pos
#
#
#		$Cape.current_idx = $Cape.IDX_MODES.LEFT
	
#	$Cape/Base.position = $Position2D.position
#	$Cape/Base.global_position = $Position2D.position
#	$Cape/Ends/Base.position = position
#	$Cape/Ends/Base.global_position = position
