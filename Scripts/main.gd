extends Spatial
export(int, 16, 64) var worldSize :=32
var offset:=0
var orient= [0,10,16,22]
export(Texture) var OSN:Texture
onready var noise=OSN.noise
var rnd := randi()

func _ready() -> void:
	$cam.start(Vector3(float(worldSize)/ 2, 0, float(worldSize) /2))
	randomize(); seed(rnd)
	noise.seed = rnd
	generate()

func generate()->void:
	for x in worldSize:
		offset = 0
		for y in worldSize:
			offset = 0 if offset == 2 else 2
			var elev = round(noise.get_noise_2d(x, y) * 25)
			var impacts=[0.97,0.7,0.9,0.55, 0.8]
			var tile:= 2
			if elev < -5: tile = 0
			if elev >= -5 and elev < 0:tile = 1
			if elev > 3 and elev <6:tile =3
			if elev >= 6: tile = 4
			$blockmap.set_cell_item(x*4+(offset), elev if tile != 0 else -5, y*3, tile)
			if randf() > impacts[tile]:
				$objmap.set_cell_item(x*4+(offset), elev+8 if tile != 0 else 2, y*3, tile, orient[randi()%orient.size()])
