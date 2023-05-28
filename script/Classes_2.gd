extends Node


#Игральная карта spielkarte
class Spielkarte:
	var obj = {}
	var num = {}
	var word = {}
	var scene = {}


	func _init(input_) -> void:
		obj.spieler = input_.spieler
		word.kind = input_.kind
		num.rank = input_.rank
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.spielkarte.instantiate()
		set_labes()


	func set_labes() -> void:
		scene.myself.set_labes(self)


#Альбом album
class Album:
	var obj = {}
	var arr = {}
	var dict = {}


	func _init(input_) -> void:
		obj.croupier = input_.croupier
		dict.ethnography = {}
		init_spielkartes()


	func init_spielkartes() -> void:
		arr.spielkarte = {}
		#total spielkartes
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
		var kinds = ["A","B","C","D"]
		var ranks = [0,1,2,2,3,4,5,6,7,8,9]
		
		for kind in kinds:
			for rank in ranks:
				var input = {}
				input.spieler = self
				input.kind = kind
				input.rank = rank
				var spielkarte = Classes_2.Spielkarte.new(input)
				arr.spielkarte.archive.append(spielkarte)


	func add_spielkarte_to_album(spielkarte_) -> void:
		obj.album.arr.spielkarte.archive.append(spielkarte_)


	func pull_spielkarte_from_archive() -> void:
		if arr.spielkarte.archive.size() == 0:
			arr.spielkarte.archive.append_array(arr.spielkarte.memoir)
			arr.spielkarte.memoir = []
		
		arr.spielkarte.archive.shuffle()
		var spielkarte = arr.spielkarte.archive.pop_front()
		arr.spielkarte.thought.append(spielkarte)
		obj.croupier.scene.myself.add_spielkarte_into_thought(spielkarte)


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


	func fill_thought() -> void:
		#discard_hand
		#reset_thought()
		
		while arr.spielkarte.thought.size() < obj.croupier.num.draw.current:
			pull_spielkarte_from_archive()