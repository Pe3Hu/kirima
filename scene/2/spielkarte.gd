extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	update_rec_size()
	update_labes()
	recolor_bg("default")


func update_rec_size() -> void:
	custom_minimum_size = Vector2(Global.vec.size.spielkarte)


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
