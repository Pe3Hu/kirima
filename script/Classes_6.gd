extends Node


#Метка etikett
class Etikett:
	var num = {}
	var obj = {}
	var word = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		word.title = input_.title
		num.counter = input_.counter
		obj.gebet = input_.gebet
		obj.spielkarte = input_.spielkarte
		obj.spielkarte.arr.etikett.append(self)
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.etikett.instantiate()
		scene.myself.set_parent(self)


	func activate() -> void:
		var description = Global.dict.etikett.title[word.title]
		print(description)
		scene.myself.queue_free()

#Молитва gebet
class Gebet:
	var obj = {}
	var num = {}
	var word = {}


	func _init(input_: Dictionary) -> void:
		word.title = input_.title
		word.type = input_.type
		word.auxiliary = input_.auxiliary
		word.etikett = input_.etikett
		num.echo = input_.echo
		num.multiplier = input_.multiplier
		obj.mönch = input_.mönch


	func calc_impact() -> void:
		var aspects = ["power"]
		aspects.append(word.auxiliary)
		var value = 0
		
		for aspect in aspects:
			var a = obj.mönch.obj.achteck.dict
			value += obj.mönch.obj.achteck.num.aspect[aspect].result * float(num.multiplier) * 0.01
		
		var description = Global.dict.etikett.title[word.etikett]
		var input = {}
		input.gebet = self
		input.title = word.etikett
		input.counter = ceil(pow(value, 1.0/description.degree))
		var bookmark = obj.mönch.get_bookmark(description)
		var archive = obj.mönch.obj.kleriker.obj.spieler.obj.opponent.obj.croupier.obj.album.arr.spielkarte.archive
		input.spielkarte = archive[bookmark]
		obj.etikett = Classes_6.Etikett.new(input)


#Дозатор abroller
class Abroller:
	var obj = {}
	var scene = {}


	func _init(input_: Dictionary) -> void:
		obj.spieltisch = input_.spieltisch
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.abroller.instantiate()
		scene.myself.set_parent(self)
		obj.spieltisch.scene.myself.get_node("VBox").add_child(scene.myself)
		obj.spieltisch.scene.myself.get_node("VBox").move_child(scene.myself, 1)
