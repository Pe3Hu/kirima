extends Node


func _ready() -> void:
	Global.obj.glaube = Classes_3.Glaube.new()
	Global.obj.kasino = Classes_0.Kasino.new()
	#datas.sort_custom(func(a, b): return a.value < b.value) 012
	
	var tempels = []
	tempels.append_array(Global.obj.glaube.arr.tempel)
	Global.obj.kasino.add_wettbewerb(tempels)
#	var spieltisch = Global.obj.kasino.arr.spieltisch.front()
#
#	for croupier in spieltisch.arr.croupier:
#		croupier.obj.album.fill_thought()
#		var spielkarte = croupier.obj.album.arr.spielkarte.thought.front()
#		croupier.obj.album.convert_thought_into_dream(spielkarte)
	
	
	for tempel in Global.obj.glaube.arr.tempel:
		for kleriker in tempel.arr.kleriker:
			kleriker.obj.mönch.dict.gebet.regular.calc_impact()


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_SPACE:
				if event.is_pressed() && !event.is_echo():
					pass


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())

