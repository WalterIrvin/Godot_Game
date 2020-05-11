extends Spatial
enum _blockTypes{
	air,
	grass
};
var _blockArray = [];
var _block = preload("res://assets/instances/Block.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	init_chunk();
	cull_faces();

func cull_faces():
	for i in range(0, len(_blockArray)):
		var block = _blockArray[i];
		block.call_deferred("check_neighbors", i, _blockArray);

func init_chunk():
	# Initializes a chunk, which is 16x16 by 256
	var offsetVec = Vector3();
	for y in range(2):
		offsetVec.y = y;
		for z in range(16):
			offsetVec.z = z;
			for x in range(16):  # one layer for the time being
				offsetVec.x = x;
				var blockObj = _block.instance();
				blockObj.call_deferred("set_data", _blockTypes.grass,
				 offsetVec);
				add_child(blockObj);
				_blockArray.append(blockObj);
