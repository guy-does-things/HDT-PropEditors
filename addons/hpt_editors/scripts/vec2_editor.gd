@tool
extends NeoEditor

## READONLY
var __component_count : int


func spinbox_update(_v) -> void:
	var vec = value
	for i in __component_count:
		vec[i] = $Components.get_child(i).value
	
	value = vec
	
func __set_initial():
	__component_count = 2
	value = Vector2.ZERO
	
	
func __setup_value():
	var is_int = [TYPE_VECTOR2I,TYPE_VECTOR3I,TYPE_VECTOR4I].has(typeof(value))
	var s = 1 if is_int else 0.001
	
	for i in __component_count:
		var box :SpinBox= $Components.get_child(i)
		box.step = s
		box.set_value_no_signal(value[i])
