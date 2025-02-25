@tool
extends NeoEditor



func spinbox_update(_v) -> void:
	var rec = value
	
	rec.position.x = %SpinBox.value
	rec.position.y = %SpinBox2.value
	rec.size.x = %SpinBox3.value
	rec.size.y = %SpinBox4.value
	
	value = rec
	
func __set_initial():
	value = Rect2()
	
	
func __setup_value():
	var is_int = typeof(value) == TYPE_RECT2I
	var s = 1 if is_int else 0.001
	
	%SpinBox.step = s 
	%SpinBox2.step = s 
	%SpinBox3.step = s 
	%SpinBox4.step = s
	
	%SpinBox.set_value_no_signal(value.position.x) 
	%SpinBox2.set_value_no_signal(value.position.y) 
	%SpinBox3.set_value_no_signal(value.size.x) 
	%SpinBox4.set_value_no_signal(value.size.y)
