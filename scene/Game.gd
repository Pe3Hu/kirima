extends Node


func _ready() -> void:
	Global.obj.glaube = Classes_3.Glaube.new()
	Global.obj.kasino = Classes_0.Kasino.new()
	#datas.sort_custom(func(a, b): return a.value < b.value) 012
	
	var tempels = []
	tempels.append_array(Global.obj.glaube.arr.tempel)
	#Global.obj.kasino.add_wettbewerb(tempels)


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_A:
				if event.is_pressed() && !event.is_echo():
					Global.obj.kasino.arr.wettbewerb.front().next_phase()
			KEY_SPACE:
				if event.is_pressed() && !event.is_echo():
					Global.obj.kasino.arr.wettbewerb.front().pause()#make_spieltisch_deals()


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())

