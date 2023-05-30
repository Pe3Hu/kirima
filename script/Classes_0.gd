extends Node


#Игровой стол spieltisch
class Spieltisch:
	var arr = {}
	var obj = {}
	var num = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		num.index = Global.num.index.spieltisch
		Global.num.index.spieltisch += 1
		obj.wettbewerb = input_.wettbewerb
		arr.croupier = input_.croupiers
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.spieltisch.instantiate()
		scene.myself.set_parent(self)
		obj.wettbewerb.scene.myself.get_node("Spieltisch").add_child(scene.myself)



#Турнир wettbewerb
class Wettbewerb:
	var arr = {}
	var num = {}
	var obj = {}
	var dict = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.kasino = input_.kasino
		dict.spieler = {}
		
		for tempel in input_.tempels:
			dict.spieler[tempel] = []
		
		init_scene()
		init_spielers()
		init_standings()
		start_round()


	func init_scene() -> void:
		scene.myself = Global.scene.wettbewerb.instantiate()
		#scene.myself.set_parent(self)
		obj.kasino.scene.myself.get_node("Wettbewerb").add_child(scene.myself)


	func init_spielers() -> void:
		for tempel in dict.spieler.keys():
			for kleriker in tempel.obj.kardinal.arr.challenger:
				var input = {}
				input.wettbewerb = self
				input.kleriker = kleriker
				var spieler = Classes_1.Spieler.new(input)
				dict.spieler[tempel].append(spieler)
		
			num.challengers = dict.spieler[tempel].size()
		
		for tempel in dict.spieler.keys():
			num.challengers = min(num.challengers, dict.spieler[tempel].size())


	func init_standings() -> void:
		dict.standings = {}
		num.round = {}
		num.round.current = 0 
		num.round.last = num.challengers - 1
		set_order()
		
		for round in num.round.last:
			dict.standings[round] = []
			
			for _i in num.challengers:
				var _j = (_i + 1 + round + num.challengers) % num.challengers
				var pair = [_i, _j]
				dict.standings[round].append(pair)


	func set_order() -> void:
		var orders = []
		orders.append_array(Global.dict.credo.keys())
		
		for tempel in dict.spieler.keys():
			for spieler in dict.spieler[tempel]:
				spieler.num.order = orders.find(spieler.obj.kleriker.word.credo)


	func start_round() -> void:
		arr.spieltisch = []
		
		for pair in dict.standings[num.round.current]:
			var input = {}
			input.wettbewerb = self
			input.croupiers = []
			
			for _i in pair.size():
				var tempel = dict.spieler.keys()[_i]
				var _j = pair[_i]
				var croupier = dict.spieler[tempel][_j].obj.croupier
				input.croupiers.append(croupier)
			
			var spieltisch = Classes_0.Spieltisch.new(input)
			arr.spieltisch.append(spieltisch)


#Казино kasino
class Kasino:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init() -> void:
		init_scene()
		arr.wettbewerb = []
		#init_spielers()
		#init_spieltischs()


	func init_scene() -> void:
		scene.myself = Global.scene.kasino.instantiate()
		Global.node.game.get_node("Layer0").add_child(scene.myself)


	func init_spieltischs() -> void:
		arr.spieltisch = []
		var input = {}
		input.kasino = self
		input.croupiers = [arr.spieler.front().obj.croupier,arr.spieler.back().obj.croupier]
		var spieltisch = Classes_0.Spieltisch.new(input)
		arr.spieltisch.append(spieltisch)


	func add_wettbewerb(tempels_: Array) -> void:
		var input = {}
		input.kasino = self
		input.tempels = tempels_
		var wettbewerb = Classes_0.Wettbewerb.new(input)
		arr.wettbewerb.append(wettbewerb)


	func init_spielers() -> void:
		arr.spieler = []
		var n = 0
		
		for _i in n:
			var input = {}
			input.kasino = self
			var spieler = Classes_1.Spieler.new(input)
			arr.spieler.append(spieler)
