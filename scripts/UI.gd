extends CanvasLayer

const HP_FONT_SIZE := 50

@export var char_manager_path: NodePath
@onready var char_manager = get_node(char_manager_path)
@onready var hp_label = $HpLabel


func _ready():
	hp_label.add_theme_font_size_override("font_size", HP_FONT_SIZE)
	

func _process(_delta): 
	display_hp()


func display_hp(): # currently updates hp every single frame, probabl hook to a signal later
	var active_char = char_manager.get_active_character()
	if active_char:
		hp_label.text = "YOUR HP: %d" % active_char.hp
