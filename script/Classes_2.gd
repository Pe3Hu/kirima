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
			etikett.obj.spielkarte.obj.album.num.etikett -= 1
			etikett.obj.spielkarte = null
			etikett.scene.myself.queue_free()


#Альбом album
class Album:
	var num = {}
	var obj = {}
	var arr = {}
	var dict = {}


	func _init(input_: Dictionary) -> void:
		num.etikett = 0
		obj.croupier = input_.croupier
		init_spielkartes()


	func init_spielkartes() -> void:
		dict.link = {}
		#archive == upcoming spielkartes
		#thought == spielkartes in hand
		dict.link["archive"] = "thought"
		#dream == spielkartes in game
		dict.link["thought"] = "dream"
		#memoir == previous spielkartes
		dict.link["dream"] = "memoir"
		dict.link["memoir"] = "archive"
		#forgotten == exiled spielkartes
		dict.link["forgotten"] = "archive"
		arr.spielkarte = {}
		
		for key in dict.link.keys():
			arr.spielkarte[key] = []
		
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


	func pull_full_section(section_: String) -> void:
		var from = section_
		var where = dict.link[section_]
		
		while arr.spielkarte[from].size() > 0:
			var spielkarte = arr.spielkarte[from].pop_front()
			arr.spielkarte[where].append(spielkarte)
			
			match section_:
				"memoir":
					obj.croupier.dict.out[spielkarte.num.rank].append(spielkarte.word.kind)


	func pull_spielkarte_from_archive() -> void:
		arr.spielkarte.archive.shuffle()
		var spielkarte = arr.spielkarte.archive.pop_front()
		arr.spielkarte.thought.append(spielkarte)
		obj.croupier.scene.myself.add_spielkarte_into_thought(spielkarte)
		obj.croupier.dict.out[spielkarte.num.rank].erase(spielkarte.word.kind)
		
		if arr.spielkarte.archive.size() == 0:
			pull_full_section("memoir")


	func convert_thought_into_dream(spielkarte_: Spielkarte) -> void:
		arr.spielkarte.thought.erase(spielkarte_)
		arr.spielkarte.dream.append(spielkarte_)
		obj.croupier.scene.myself.convert_thought_into_dream(spielkarte_)


	func fill_thought() -> void:
		while arr.spielkarte.thought.size() < obj.croupier.num.draw.current:
			pull_spielkarte_from_archive()


	func full_reset() -> void:
		var sections = ["thought", "dream", "memoir", "forgotten"]
		
		for section in sections:
			pull_full_section(section)
		
		clear_archive_from_etiketts()
		get_etiketts_count()


	func clear_archive_from_etiketts() -> void:
		for spielkarte in arr.spielkarte.archive:
			spielkarte.clear_etiketts()


	func get_etiketts_count() -> void:
		var old = 0+num.etikett
		num.etikett = 0
		
		for spielkarte in arr.spielkarte.archive:
			num.etikett += spielkarte.arr.etikett.size()
