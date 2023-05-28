extends Node


func _ready() -> void:
	Global.obj.kasino = Classes_0.Kasino.new()
	#datas.sort_custom(func(a, b): return a.value < b.value) 012
	
	var spieltisch = Global.obj.kasino.arr.spieltisch.front()
	
	for croupier in spieltisch.arr.croupier:
		croupier.obj.album.fill_thought()
		var spielkarte = croupier.obj.album.arr.spielkarte.thought.front()
		croupier.obj.album.convert_thought_into_dream(spielkarte)


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_SPACE:
				if event.is_pressed() && !event.is_echo():
					pass


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())

