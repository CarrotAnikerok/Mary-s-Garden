extends PanelContainer


@onready var mary_text = %MaryText

@export var phrases: Array[String] = [
	"Привет! Добро пожаловать в оранжерею!", 
	"Здесь я ухаживаю за растениями.", 
	"Для каждого растения нужно следить за его поливом, уровнем влажности и светом.",
	"В справочнике я записала основную информацию о растениях, но четкие цифры насчет таких вещей сказать сложно.",
	"Придется эксперементировать и смотреть, как именно растение реагирует на условия, в которых находится,",
	"И в зависимости от этого что-то менять.",
	"Так же я делаю букеты, чаи и духи из растений, когда у меня есть материалы.",
	"Их можно получить, если растение чувствует себя хорошо или цветет.",
]
var phrase_index: int

func _ready():
	mary_text.text = phrases[phrase_index]
	phrase_index += 1


func _process(delta):
	pass


func _on_gui_input(event):
	if event.is_action_pressed("click"):
		if phrase_index < phrases.size():
			mary_text.text = phrases[phrase_index]
			phrase_index += 1
		else:
			hide()
