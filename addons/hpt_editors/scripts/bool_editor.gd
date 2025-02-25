@tool
extends NeoEditor


func __set_initial():value = false
func __setup_value():$CheckBox.set_pressed_no_signal(value)
func _on_check_box_toggled(button_pressed):value = button_pressed
