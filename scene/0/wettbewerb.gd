extends MarginContainer


var parent = null
var tween = null


func set_parent(parent_) -> void:
	parent = parent_


func follow_phase() -> void:
	if !parent.flag.end:
		var time = 0.05
		tween = create_tween()
		tween.tween_property(self, "position", 0, time)
		tween.tween_callback(call_follow_phase)


func call_follow_phase() -> void:
	var phase = parent.arr.phase.pop_front()
	var words = phase.split(" ")
	var func_name = ""
	
	for _i in words.size():
		var word = words[_i]
		func_name += word
		
		if _i != words.size()-1:
			func_name += "_"
	
	for spieltisch in parent.arr.spieltisch:
		Callable(spieltisch, func_name).call()
		
	if parent.arr.phase.size() == 0:
		parent.set_phases_by_wettbewerb()
	
	follow_phase()