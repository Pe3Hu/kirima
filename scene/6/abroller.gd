extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_


func set_grid_cols() -> void:
	var cols = $Etikett.get_child_count()
	$Etikett.columns = cols


func activate_all_etiketts():
	while  $Etikett.get_child_count() > 0:
		activate_next_etikett()


func activate_next_etikett():
	var etikett = $Etikett.get_children().pop_front()
	$Etikett.remove_child(etikett)
	etikett.parent.activate()
