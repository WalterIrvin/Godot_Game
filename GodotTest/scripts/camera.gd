extends Spatial

onready var _player_ref = get_owner();
var _mouse_sensitivity = 0.05;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_movement = event.relative;
		_player_ref.rotation.y += -deg2rad(mouse_movement.x * _mouse_sensitivity);
		var look_up_amt = -deg2rad(mouse_movement.y * _mouse_sensitivity);
		if abs(rotation.x + look_up_amt) < 1.57:
			rotation.x += -deg2rad(mouse_movement.y * _mouse_sensitivity);
