class_name HPTEditorUtil

## only used to avoid overwriting on type switches from floats to ints
static func can_be_conv_to_num(type:int):
	return type == TYPE_INT || type == TYPE_FLOAT || type == TYPE_BOOL
static func can_be_conv_to_vec2num(type:int):
	return (type == TYPE_VECTOR2 || type == TYPE_VECTOR2I)
static func can_be_conv_to_vec3num(type:int):
	return (type == TYPE_VECTOR3 || type == TYPE_VECTOR3I)
static func can_be_conv_to_vec4num(type:int):
	return (type == TYPE_VECTOR4 || type == TYPE_VECTOR4I)
static func can_be_conv_to_rec2num(type:int):
	return (type == TYPE_RECT2 || type == TYPE_RECT2I)

static func is_valid_type(t:int):
	return (
		t == TYPE_NIL ||
		t == TYPE_BOOL || 
		t == TYPE_INT || 
		t == TYPE_FLOAT || 
		t == TYPE_STRING || 
		t == TYPE_VECTOR2 || 
		t == TYPE_VECTOR2I || 
		t == TYPE_RECT2 ||
		t == TYPE_RECT2I ||
		t == TYPE_VECTOR3 ||
		t == TYPE_VECTOR3I ||
		t == TYPE_VECTOR4 ||
		t == TYPE_VECTOR4I || 
		t == TYPE_ARRAY ||
		t == TYPE_COLOR || 
		t == TYPE_PACKED_COLOR_ARRAY ||
		t == TYPE_PACKED_VECTOR2_ARRAY ||
		t == TYPE_PACKED_VECTOR3_ARRAY ||
		t == TYPE_PACKED_VECTOR4_ARRAY ||
		t == TYPE_PACKED_FLOAT32_ARRAY ||
		t == TYPE_PACKED_FLOAT64_ARRAY ||
		t == TYPE_PACKED_INT32_ARRAY ||
		t == TYPE_PACKED_INT64_ARRAY ||
		t == TYPE_PACKED_BYTE_ARRAY ||
		t == TYPE_PACKED_STRING_ARRAY
	)

static func get_type_icon_name(t:int):
	match t:
		TYPE_NIL:return "null"
		TYPE_BOOL:return "bool"
		TYPE_INT:return "int"
		TYPE_FLOAT:return "float"
		TYPE_STRING:return "String"
		TYPE_VECTOR2:return "Vector2"
		TYPE_VECTOR2I:return "Vector2i"
		TYPE_RECT2:return "Rect2"
		TYPE_RECT2I:return "Rect2i"
		TYPE_VECTOR3:return "Vector3"
		TYPE_VECTOR3I:return "Vector3i"
		TYPE_VECTOR4:return "Vector4"
		TYPE_VECTOR4I:return "Vector4i"
		TYPE_ARRAY:return "Array"
		TYPE_COLOR:return "Color"

		TYPE_PACKED_COLOR_ARRAY:return "PackedColorArray"
		TYPE_PACKED_VECTOR2_ARRAY:return "PackedVector2Array"
		TYPE_PACKED_VECTOR3_ARRAY:return "PackedVector3Array"
		TYPE_PACKED_VECTOR4_ARRAY:return "PackedVector4Array"
		TYPE_PACKED_FLOAT32_ARRAY:return "PackedFloat32Array"
		TYPE_PACKED_FLOAT64_ARRAY:return "PackedFloat64Array"
		TYPE_PACKED_INT32_ARRAY:return "PackedInt32Array"
		TYPE_PACKED_INT64_ARRAY:return "PackedInt64Array"
		TYPE_PACKED_BYTE_ARRAY:return "PackedByteArray"
		TYPE_PACKED_STRING_ARRAY:return "PackedStringArray"
	return ""  

static func get_type_default_val(t):
	match t:
		TYPE_BOOL:return false
		TYPE_INT:return 0
		TYPE_FLOAT:return 0.0
		TYPE_STRING:return ""
		TYPE_VECTOR2:return Vector2.ZERO
		TYPE_VECTOR2I:return Vector2i.ZERO
		TYPE_RECT2:return Rect2(0,0,0,0)
		TYPE_RECT2I:return Rect2i(Vector2.ZERO,Vector2.ZERO)
		TYPE_VECTOR3:return Vector3.ZERO
		TYPE_VECTOR3I:return Vector3i.ZERO
		TYPE_VECTOR4:return Vector4.ZERO
		TYPE_VECTOR4I:return Vector4i.ZERO
		TYPE_ARRAY:return []
		TYPE_COLOR:return Color.BLACK
		TYPE_PACKED_COLOR_ARRAY:return PackedColorArray([])
		TYPE_PACKED_VECTOR2_ARRAY:return PackedVector2Array([])
		TYPE_PACKED_VECTOR3_ARRAY:return PackedVector3Array([])
		TYPE_PACKED_VECTOR4_ARRAY:return PackedVector4Array([])
		TYPE_PACKED_FLOAT32_ARRAY:return PackedFloat32Array([])
		TYPE_PACKED_FLOAT64_ARRAY:return PackedFloat64Array([])
		TYPE_PACKED_INT32_ARRAY:return PackedInt32Array([])
		TYPE_PACKED_INT64_ARRAY:return PackedInt64Array([])
		TYPE_PACKED_BYTE_ARRAY:return PackedByteArray([])
		TYPE_PACKED_STRING_ARRAY:return PackedStringArray([])
	return null

static func get_default_val(v):
	match typeof(v):
		TYPE_ARRAY:
			return Array([],v.get_typed_builtin(),v.get_typed_class_name(),v.get_typed_script())
	return get_type_default_val( typeof(v) )




static func get_editor(type)->NeoEditor:
	var editor :NeoEditor
	match type:
		TYPE_INT:editor = preload("res://addons/hpt_editors/converted_eds/number_editor.tscn").instantiate()
		TYPE_FLOAT:editor = preload("res://addons/hpt_editors/converted_eds/number_editor.tscn").instantiate()
		TYPE_BOOL:editor = preload("res://addons/hpt_editors/converted_eds/bool_editor.tscn").instantiate()
		TYPE_STRING:editor = preload("res://addons/hpt_editors/converted_eds/string_editor.tscn").instantiate()
		TYPE_VECTOR2:editor = preload("res://addons/hpt_editors/converted_eds/vec2_editor.tscn").instantiate()
		TYPE_VECTOR2I:editor = preload("res://addons/hpt_editors/converted_eds/vec2_editor.tscn").instantiate()
		TYPE_VECTOR3:editor = preload("res://addons/hpt_editors/converted_eds/vec3_editor.tscn").instantiate()
		TYPE_VECTOR3I:editor = preload("res://addons/hpt_editors/converted_eds/vec3_editor.tscn").instantiate()
		TYPE_VECTOR4:editor = preload("res://addons/hpt_editors/converted_eds/vec4_editor.tscn").instantiate()
		TYPE_VECTOR4I:editor = preload("res://addons/hpt_editors/converted_eds/vec4_editor.tscn").instantiate()
		TYPE_RECT2:editor = preload("res://addons/hpt_editors/converted_eds/rect_editor.tscn").instantiate()
		TYPE_RECT2I:editor = preload("res://addons/hpt_editors/converted_eds/rect_editor.tscn").instantiate()	
		TYPE_COLOR:editor = preload("res://addons/hpt_editors/converted_eds/color_editor.tscn").instantiate()
		TYPE_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_COLOR_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_VECTOR2_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_VECTOR3_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_VECTOR4_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_FLOAT32_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_FLOAT64_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_INT32_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_INT64_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_BYTE_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		TYPE_PACKED_STRING_ARRAY:editor = preload("res://addons/hpt_editors/converted_eds/array_editor.tscn").instantiate()
		_:editor = preload("res://addons/hpt_editors/converted_eds/default_editor.tscn").instantiate()

	return editor



static func get_editor_extended(type:int,export_hint:int)->NeoEditor:
	match export_hint:
		PROPERTY_HINT_ENUM:
			return preload("res://addons/hpt_editors/converted_eds/enum_editor.tscn").instantiate()
		PROPERTY_HINT_FLAGS:
			return preload("res://addons/hpt_editors/converted_eds/flag_editor.tscn").instantiate()
		
	return get_editor(type)
