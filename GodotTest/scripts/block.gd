extends StaticBody


var _id = 0;
var _offset = Vector3();  # position in the chunk
var _size = Vector3();
onready var _collider = self.get_node("CollisionShape");

func _process(delta):
	pass

func set_data(id, offset):
	_id = id;
	_offset = offset;
	_size = _collider.scale;
	translate_object_local(_offset * (_size * 2.1));
