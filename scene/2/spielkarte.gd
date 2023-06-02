extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	update_rec_size()
	update_labes()
	recolor_bg("default")


func update_rec_size() -> void:
	custom_minimum_size = Vector2(Global.vec.size.node.spielkarte)


func update_labes() -> void:
	$Label/Kind/Value.text = parent.word.kind
	$Label/Rank/Value.text = str(parent.num.rank)


func recolor_bg(layer_: String) -> void:
	match layer_:
		"default":
			$BG.color = Color.BLACK
		"winner":
			$BG.color = Color.BLACK
		"loser":
			$BG.color = Color.WHITE
		"tie":
			$BG.color = Color.LIGHT_GRAY


func give_away_etiketts() -> void:
	recolor_bg("default")
	
	while parent.arr.etikett.size() > 0:
		var etikett = parent.arr.etikett.pop_front()
		etikett.scene.myself.add_to_abroller()
		parent.obj.album.num.etikett -= 1
