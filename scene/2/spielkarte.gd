extends MarginContainer


func set_labes(parent_) -> void:
	$Label/Kind.text = parent_.word.kind
	$Label/Rank.text = str(parent_.num.rank)
