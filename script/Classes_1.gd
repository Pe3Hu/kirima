extends Node


#Крупье croupier
class Croupier:
	var num = {}
	var obj = {}
	var dict = {}
	var flag = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.draw = {}
		num.draw.total = input_.draw
		num.draw.current = num.draw.total
		num.harmony = 0
		obj.spieler = input_.spieler
		obj.spieltisch = null
		flag.skip = false
		flag.white_skin = false
		dict.out = {}
		init_scene()
		init_album()


	func init_scene() -> void:
		scene.myself = Global.scene.croupier.instantiate()
		scene.myself.set_parent(self)


	func init_album() -> void:
		var input = {}
		input.croupier = self
		obj.album = Classes_2.Album.new(input)


	func pull_standard_spielkartes():
		flag.skip = false
		flag.white_skin = false
		obj.album.fill_thought()
		
		for _i in range(obj.album.arr.spielkarte.thought.size()-1, -1, -1):
			var spielkarte = obj.album.arr.spielkarte.thought[_i]
			obj.album.convert_thought_into_dream(spielkarte)
		
		update_harmony()


	func pull_additional_spielkartes():
		while !flag.skip:
			var outcomes = calc_chance_of_losing()
			var outcome = Global.get_random_key(outcomes)
			
			match outcome:
				"good":
					obj.album.pull_spielkarte_from_archive()
					var spielkarte = obj.album.arr.spielkarte.thought.front()
					obj.album.convert_thought_into_dream(spielkarte)
					update_harmony()
				"bad":
					flag.skip = true


	func update_harmony():
		num.harmony = 0
		
		for spielkarte in obj.album.arr.spielkarte.dream:
			num.harmony += spielkarte.num.rank
		
		if num.harmony > Global.num.spielkarte.rank.white_skin:
			flag.skip = true
			flag.white_skin = true


	func calc_chance_of_losing() -> Dictionary:
		var outcomes = {}
		outcomes.good = 0
		outcomes.bad = 0
		
		for rank in dict.out.keys():
			if rank + num.harmony > Global.num.spielkarte.rank.white_skin:
				outcomes.bad += dict.out[rank].size()
			else:
				outcomes.good += dict.out[rank].size()
		
		return outcomes


	func reset_dream() -> void:
		obj.album.reset_dream()
		scene.myself.remove_spielkartes_from_dream()


#Игрок spieler
class Spieler:
	var arr = {}
	var num = {}
	var obj = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.index = Global.num.index.spieler
		Global.num.index.spieler += 1
		num.order = -1
		obj.wettbewerb = input_.wettbewerb
		obj.spieltisch = null
		obj.kleriker = input_.kleriker
		obj.kleriker.obj.spieler = self
		obj.opponent = null
		init_croupier()


	func init_croupier() -> void:
		var input = {}
		input.draw = 2
		input.spieler = self
		obj.croupier = Classes_1.Croupier.new(input)


	func set_opponent():
		if obj.croupier.obj.spieltisch != null:
			var opponents = []
			opponents.append_array(obj.croupier.obj.spieltisch.arr.croupier)
			opponents.erase(obj.croupier)
			obj.opponent = opponents.front().obj.spieler
		else:
			print("#error 0# Spieler -> set_opponent")
