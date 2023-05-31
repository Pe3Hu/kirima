extends Node


#Игральная карта spielkarte
class Spielkarte:
	var obj = {}
	var num = {}
	var word = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.spieler = input_.spieler
		word.kind = input_.kind
		num.rank = input_.rank
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.spielkarte.instantiate()
		scene.myself.set_parent(self)


#Альбом album
class Album:
	var obj = {}
	var arr = {}
	var dict = {}


	func _init(input_: Dictionary) -> void:
		obj.croupier = input_.croupier
		dict.ethnography = {}
		init_spielkartes()


	func init_spielkartes() -> void:
		arr.spielkarte = {}
		#upcoming spielkartes
		arr.spielkarte.archive = []
		#spielkartes in hand
		arr.spielkarte.thought = []
		#spielkartes in game
		arr.spielkarte.dream = []
		#previous spielkartes
		arr.spielkarte.memoir = []
		#exiled spielkartes
		arr.spielkarte.forgotten = []
		
		set_standard_content_of_album()


	func set_standard_content_of_album() -> void:
		#for alphabet in Global.obj.lexikon.arr.alphabet:
		#	for spielkarte in alphabet.arr.spielkarte:
		#		add_spielkarte_to_album(spielkarte)
		var kinds = ["A","B","C","D","E","F","G"]
		var ranks = [1,2,3,4,5,6,7]
		
		for kind in kinds:
			for rank in ranks:
				if !obj.croupier.dict.out.keys().has(rank):
					obj.croupier.dict.out[rank] = []
				
				obj.croupier.dict.out[rank].append(kind)
				var input = {}
				input.spieler = self
				input.kind = kind
				input.rank = rank
				var spielkarte = Classes_2.Spielkarte.new(input)
				arr.spielkarte.archive.append(spielkarte)


	func pull_spielkarte_from_archive() -> void:
		if arr.spielkarte.archive.size() == 0:
			while arr.spielkarte.memoir.size() > 0:
				var spielkarte = arr.spielkarte.pop_front()
				arr.spielkarte.archive.append(spielkarte)
				obj.croupier.dict.out[spielkarte.num.rank].append(spielkarte.word.kind)
		
		arr.spielkarte.archive.shuffle()
		var spielkarte = arr.spielkarte.archive.pop_front()
		arr.spielkarte.thought.append(spielkarte)
		obj.croupier.scene.myself.add_spielkarte_into_thought(spielkarte)
		obj.croupier.dict.out[spielkarte.num.rank].erase(spielkarte.word.kind)


	func reset_thought() -> void:
		while arr.spielkarte.thought.size() > 0:
			var spielkarte = arr.spielkarte.thought.pop_front()
			arr.spielkarte.thought.erase(spielkarte)
			arr.spielkarte.memoir.append(spielkarte)


	func reset_dream() -> void:
		while arr.spielkarte.dream.size() > 0:
			var spielkarte = arr.spielkarte.dream.pop_front()
			arr.spielkarte.dream.erase(spielkarte)
			arr.spielkarte.memoir.append(spielkarte)


	func convert_thought_into_dream(spielkarte_: Spielkarte) -> void:
		arr.spielkarte.thought.erase(spielkarte_)
		arr.spielkarte.dream.append(spielkarte_)
		obj.croupier.scene.myself.convert_thought_into_dream(spielkarte_)


	func fill_thought() -> void:
		while arr.spielkarte.thought.size() < obj.croupier.num.draw.current:
			pull_spielkarte_from_archive()
