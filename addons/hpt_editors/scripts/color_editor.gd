@tool
extends NeoEditor



func __set_initial():value = Color.BLACK
func __setup_value():$ColorPickerButton.color = value


func _on_color_picker_button_color_changed(color: Color) -> void:
	if color == value:return
	value = color
