extends Node


#Игральная карта spielkarte
class Spielkarte:
	var arr = {}
	var obj = {}
	var num = {}
	var word = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.album = input_.album
		word.kind = input_.kind
		num.rank = input_.rank
		arr.etikett = []
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.spielkarte.instantiate()
		scene.myself.set_parent(self)


	func clear_etiketts() -> void:
		while arr.etikett.size() > 0:
			var etikett = arr.etikett.pop_front()
			etikett.obj.spielkarte = null
			etikett.scene.myself.queue_free()


#Альбом album
class Album:
	var obj = {}
	var arr = {}


	func _init(input_: Dictionary) -> void:
		obj.croupier = input_.croupier
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
				input.album = self
				input.kind = kind
				input.rank = rank
				var spielkarte = Classes_2.Spielkarte.new(input)
				arr.spielkarte.archive.append(spielkarte)


	func pull_spielkarte_from_archive() -> void:
		arr.spielkarte.archive.shuffle()
		var spielkarte = arr.spielkarte.archive.pop_front()
		arr.spielkarte.thought.append(spielkarte)
		obj.croupier.scene.myself.add_spielkarte_into_thought(spielkarte)
		obj.croupier.dict.out[spielkarte.num.rank].erase(spielkarte.word.kind)
		
		if arr.spielkarte.archive.size() == 0:
			pull_full_memoir_to_archive()


	func pull_full_memoir_to_archive() -> void:
		while arr.spielkarte.memoir.size() > 0:
			var spielkarte = arr.spielkarte.memoir.pop_front()
			arr.spielkarte.archive.append(spielkarte)
			obj.croupier.dict.out[spielkarte.num.rank].append(spielkarte.word.kind)


	func pull_full_thought_to_memoir() -> void:
		while arr.spielkarte.thought.size() > 0:
			var spielkarte = arr.spielkarte.thought.pop_front()
			arr.spielkarte.thought.erase(spielkarte)
			arr.spielkarte.memoir.append(spielkarte)


	func pull_full_dream_to_memoir() -> void:
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


	func full_reset() -> void:
		while arr.spielkarte.thought.size() > 0:
			var spielkarte = arr.spielkarte.thought.pop_front()
			convert_thought_into_dream(spielkarte)
		
		pull_full_dream_to_memoir()
		pull_full_memoir_to_archive()
		clear_archive_from_etiketts()


	func clear_archive_from_etiketts() -> void:
		for spielkarte in arr.spielkarte.archive:
			spielkarte.clear_etiketts()
