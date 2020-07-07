extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

onready var cloak = get_node("Base")


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
	
enum DIR {LEFT, RIGHT}
func flip(dir):
	if (dir == DIR.LEFT):
		$Sprite.flip_h = true
		$Base.scale.x = -1
	elif(dir == DIR.RIGHT):
		$Sprite.flip_h = false
		$Base.scale.x = 1

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

	if velocity.x > 0.0:
#		$Sprite.flip_h = false
#		scale.x = 1
		flip(DIR.RIGHT)
		cloak.current_idx = cloak.IDX_MODES.RIGHT
	elif velocity.x < 0.0:
#		$Sprite.flip_h = true
		flip(DIR.LEFT)
		cloak.current_idx = cloak.IDX_MODES.LEFT
	elif velocity.y > 0.0:
		cloak.current_idx = cloak.IDX_MODES.DOWN
	elif velocity.y < 0.0:
		cloak.current_idx = cloak.IDX_MODES.UP
	else:
		cloak.current_idx = cloak.IDX_MODES.IDLE

