class_name EssentialRecipe
extends Resource


@export var ingridient: Ingridient
@export var oil: Ingridient


func create() -> void:
	PlantProductInfo.remove_ingridient(ingridient)
	PlantProductInfo.add_ingridient(oil)
	

func can_create_local(element: Ingridient):
	if ingridient.ingridient_name == element.ingridient_name:
		return true
	else:
		return false
