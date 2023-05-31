extends Node


#Метка etikett
class Etikett:
	var num = {}
	var word = {}


	func _init(input_: Dictionary) -> void:
		word.title = input_.title
		num.counter = input_.counter
		num.bookmark = input_.bookmark


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
		input.title = word.etikett
		input.counter = ceil(pow(value, 1.0/description.degree))
		input.bookmark = obj.mönch.get_bookmark(description.scatter)
