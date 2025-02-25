@tool
extends NeoEditor


func __set_initial():value = ""
func __setup_value():
	if $LineEdit.text == value:return
	$LineEdit.text = value



func _on_line_edit_text_changed(new_text):
	value = new_text
	#set_value(new_text)
