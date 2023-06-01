extends MarginContainer


var parent = null
var tween = null


func set_parent(parent_) -> void:
	parent = parent_
	set_spielers()
	update_color()


func set_spielers() -> void:
	for croupier in parent.arr.croupier:
		croupier.obj.spieltisch = parent
		$VBox.add_child(croupier.scene.myself)


func update_color() -> void:
	var max_h = 360.0
	var h = float(parent.num.index)/Global.num.index.spieltisch
	var s = 0.75
	var v = 0.5
	
	var color_ = Color.from_hsv(h, s, v)
	$BG.set_color(color_)


func follow_phase() -> void:
	if parent.obj.winner == null:
		var time = 0.05
		tween = create_tween()
		tween.tween_property(self, "position", 0, time)
		tween.tween_callback(call_follow_phase)


func call_follow_phase() -> void:
	var phase = parent.obj.wettbewerb.arr.phase.front()
	var words = phase.split(" ")
	var func_name = ""
	
	for _i in words.size():
		var word = words[_i]
		func_name += word
		
		if _i != words.size()-1:
			func_name += "_"
	
	print(func_name)
	Callable(parent, func_name).call()


func claer_after_close() -> void:
	var node = $VBox
	
	while node.get_child_count() > 0:
		var child = node.get_children().pop_front()
		node.remove_child(child)
	
	parent.obj.abroller.scene.myself.queue_free()
	parent.obj.abroller.obj.spieltisch = null
	parent.obj.wettbewerb.arr.spieltisch.erase(parent)
	parent.obj.wettbewerb.check_end()
	queue_free()
