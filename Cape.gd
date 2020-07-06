extends Node

const approch_indexes = [ Vector2(0.0, 1.0), Vector2(-0.5, 4.0) , Vector2(-1, 6.0) ]

onready var follow1 = get_node("Follow1")
onready var follow2 = get_node("Follow2")
onready var base = get_node("Base")

export var follow_speed = 20

export (int) var speed = 200

var velocity = Vector2()

func _physics_process(delta):
#	get_input()
#	#velocity = move_and_slide(velocity)
#
#	var mouse_pos = get_local_mouse_position()
#
#	base.position = mouse_pos
	#base.position = self.position
	
	follow1.position = follow1.position.linear_interpolate(base.position + approch_indexes[1], delta * follow_speed)
	follow2.position = follow2.position.linear_interpolate(follow1.position + approch_indexes[2] , delta * (follow_speed-10))

#	follow1.global_position = follow1.global_position.linear_interpolate(base.global_position, delta * follow_speed)
#	follow2.global_position = follow2.global_position.linear_interpolate(follow1.global_position, delta * (follow_speed-10))
	
#	follow1.global_position = follow1.global_position.linear_interpolate(base.global_position + approch_indexes[1], delta * follow_speed)
#	follow2.global_position = follow2.global_position.linear_interpolate(follow1.global_position + approch_indexes[2] , delta * (follow_speed-10))
#	lerp(follow1.position, base.position + approch_indexes[1], 0.1)
#	lerp(follow2.position, follow2.position + approch_indexes[2], 0.1)

func _ready():
##	base.position = Vector2.ZERO
#	follow1.global_position = base.global_position + approch_indexes[1]
#	follow2.global_position = follow2.global_position + approch_indexes[2]
	pass
	
func _process(delta):
	pass
