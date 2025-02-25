@tool
extends NeoEditor


func __set_initial():
	value = 0.0


func __setup_value():
	var is_int = typeof(value) == TYPE_INT
	var s = 1 if is_int else 0.001
	%SpinBox.step =s
	%SpinBox.set_value_no_signal(value)


func _on_spin_box_value_changed(value: float) -> void:
	if typeof(self.value) == TYPE_INT:
		self.value = int(value)
		return
		
	self.value = value


func get_spinbox()->SpinBox:
	return %SpinBox
