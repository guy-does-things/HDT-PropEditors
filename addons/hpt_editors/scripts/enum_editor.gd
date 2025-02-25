@tool
extends NeoEditor




func __set_initial():
	value = 0

func setup_hintstr(hintstr:String):
	%OptionButton.clear()
	var splitflags = hintstr.split(",")
	
	for splitflag in splitflags:
		var assigned_bitwise = splitflag.split(":",true)
		%OptionButton.add_item(assigned_bitwise[0])

func __setup_value():
	%OptionButton.selected = value
	
func _on_option_button_item_selected(index: int) -> void:
	var enumitem = %OptionButton.get_item_id(index)
	if value == enumitem:return
	value = enumitem
