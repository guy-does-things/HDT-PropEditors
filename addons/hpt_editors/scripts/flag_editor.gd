@tool
extends NeoEditor


@onready var popup_menu :PopupMenu= %MenuButton.get_popup()

func _ready() -> void:
	super()
	popup_menu.id_pressed.connect(_on_id_pressed)
	popup_menu.hide_on_checkable_item_selection = false

func __set_initial():
	value = 0

func setup_hintstr(hintstr:String):
	popup_menu.clear()
	var splitflags = hintstr.split(",")
	
	var i = 0
	for splitflag in splitflags:
		var assigned_bitwise = splitflag.split(":",true)
		var bitwise_num = 0 if assigned_bitwise.size() == 1 else int(assigned_bitwise[1])

		
		popup_menu.add_check_item(assigned_bitwise[0])
		popup_menu.set_item_metadata(-1,bitwise_num if bitwise_num != 0 else 1 << i)
		i += 1


func __setup_value():
	for i in popup_menu.item_count:
		var bitwise_val = popup_menu.get_item_metadata(i)
		
		popup_menu.set_item_checked(i,(bitwise_val & value) == bitwise_val)
			
	


func _on_id_pressed(id):
	var mask = popup_menu.get_item_metadata(id)
	popup_menu.toggle_item_checked(id)
	if popup_menu.is_item_checked(id):value |= mask
	else:value &= ~mask
