extends Sprite

enum IDX_MODES {IDLE, UP, DOWN, RIGHT, LEFT}

const MAX_OFFSET = 1
const MIN_OFFSET = -1

const approch_indexes = [[ Vector2(0.0, 1.0), Vector2(-0.0, 3.0) , Vector2(-0, 6.0) ],
[ Vector2(0.0, 1.0), Vector2(0.0, 4.0) , Vector2(0.0, 5.0) ],
[ Vector2(0.0, -1.0), Vector2(0.0, -4.0) , Vector2(0.0, -5.0) ],
[ Vector2(-1.0, 0.0), Vector2(-4.0, 0.0) , Vector2(-6.0, 0.0) ],
[ Vector2(1.0, 0.0), Vector2(4.0, 0.0) , Vector2(6.0, 0.0) ]]

var FOLLOW_SPEEDS = [20, 40, 40, 30, 30]
const RESTING_FOLLOW_SPEED = 1
const TRASNI_FOLLOW_SPEED = 10

onready var follow1 = get_node("Node/Follow1")
onready var follow2 = get_node("Node/Follow2")
#onready var base = get_node("Base")

var rng = RandomNumberGenerator.new()

export var follow_speed = 20

var current_idx = IDX_MODES.IDLE setget current_idx_set, current_idx_get

func current_idx_set(new_idx):
	if current_idx != IDX_MODES.IDLE and new_idx == IDX_MODES.IDLE:
		FOLLOW_SPEEDS[0] = TRASNI_FOLLOW_SPEED
		$Timer.start(1)
	if current_idx == IDX_MODES.IDLE:
		time_offset = 2
	else:
		time_offset = 0.5
		
	current_idx = new_idx
	
func current_idx_get():
	return current_idx

var time_offset = 1
var cur_time = 0

var last_base_pos = Vector2(0,0)

func _ready():
	rng.randomize()

func _physics_process(delta):
#	var mouse_pos = get_global_mouse_position()
#	global_position = mouse_pos
	
	cur_time += delta

	if cur_time > time_offset:
		cur_time = 0
		var offset = Vector2()

#		offset.x = rng.randi_range(MIN_OFFSET, MAX_OFFSET)
#		offset.y = rng.randi_range(MIN_OFFSET, MAX_OFFSET)
#		follow1.global_position += offset
		
		offset.x = rng.randi_range(MIN_OFFSET, MAX_OFFSET)
#		offset.y = rng.randi_range(MIN_OFFSET, MAX_OFFSET)
		follow1.global_position += offset


	follow1.global_position = follow1.global_position.linear_interpolate(global_position + approch_indexes[current_idx][1], delta * FOLLOW_SPEEDS[current_idx])
	follow2.global_position = follow2.global_position.linear_interpolate(follow1.global_position + approch_indexes[current_idx][2] , delta * FOLLOW_SPEEDS[current_idx])
	
#	rotation = global_position.angle_to_point(get_parent().velocity.angle()) - PI /2
	rotation = get_parent().velocity.angle() + PI /2
	follow1.rotation = follow1.global_position.angle_to_point(global_position) - PI /2
	follow2.rotation = follow2.global_position.angle_to_point(follow1.global_position) - PI /2
		

func _on_Timer_timeout():
	FOLLOW_SPEEDS[0] = RESTING_FOLLOW_SPEED
