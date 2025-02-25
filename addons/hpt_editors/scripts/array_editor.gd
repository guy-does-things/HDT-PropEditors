@tool
extends NeoEditor

class TypeSwitchButton extends OptionButton:
	signal change_type(type)
	var cur_type = 0
	func _ready() -> void:
		clear()
		var selected_idx = 0
		var count = 0
		
		for type in TYPE_MAX:
			if !HPTEditorUtil.is_valid_type(type):continue
			if type == cur_type:selected_idx = count
			add_item(HPTEditorUtil.get_type_icon_name(type))
			set_item_metadata(-1,type)
			set_item_icon(-1,get_theme_icon(HPTEditorUtil.get_type_icon_name(type),"EditorIcons"))
			count += 1
		
		## magic number for deletion, will never be used
		add_item("Delete",-1)
		set_item_metadata(-1,0xffff)
		
		selected = selected_idx
		item_selected.connect(_on_item_selected)


	func _on_item_selected(item:int):
		if get_item_metadata(item) == cur_type:return
		change_type.emit(get_item_metadata(item))


## only exists because packedarrays as being Changed if you edit a value 
var editing = false
var editors = []




func __set_value(val):
	if editing:return
	editing = true
	super(val)
	editing = false



func __set_initial():
	value = []

	
func __setup_value():
	%ArraySize.value = int(value.size())
	populate_editors()
	

func get_static_type_info()->int:
	if value is Array:return value.get_typed_builtin()
	match typeof(value):
		TYPE_PACKED_COLOR_ARRAY:return TYPE_COLOR
		TYPE_PACKED_VECTOR2_ARRAY:return TYPE_VECTOR2
		TYPE_PACKED_VECTOR3_ARRAY:return TYPE_VECTOR3
		TYPE_PACKED_VECTOR4_ARRAY:return TYPE_VECTOR4
		TYPE_PACKED_FLOAT32_ARRAY:return TYPE_FLOAT
		TYPE_PACKED_FLOAT64_ARRAY:return TYPE_FLOAT
		TYPE_PACKED_INT32_ARRAY:return TYPE_INT
		TYPE_PACKED_INT64_ARRAY:return TYPE_INT
		TYPE_PACKED_BYTE_ARRAY:return TYPE_INT
		TYPE_PACKED_STRING_ARRAY:return TYPE_STRING
	return TYPE_NIL
		


func populate_editors():
	for editor in editors:editor.queue_free()
	editors.clear()
	var editor_parent = %ElementEditorParent
	var value_type = typeof(value)
	
	for i in range(value.size()):
		var editorbox = HBoxContainer.new()
		var arval = value[i]
		var editor : NeoEditor = HPTEditorUtil.get_editor(typeof(arval))
		editorbox.size_flags_horizontal |= Control.SIZE_EXPAND_FILL
		editor.size_flags_horizontal |= Control.SIZE_EXPAND_FILL
		editor.value_changed.connect(sub_editor_modified.bind(i))
		editorbox.add_child(editor)
		editor_parent.add_child(editorbox)
		editors.append(editorbox)
		editor.prop_name = str(i)

		if get_static_type_info() == TYPE_NIL:
			var changebtn = TypeSwitchButton.new()
			if HPTEditorUtil.is_valid_type(typeof(arval)):changebtn.cur_type = typeof(arval)
			changebtn.change_type.connect(type_value_changed.bind(i))
			editorbox.add_child(changebtn)
		else:
			var delbtn = Button.new()
			delbtn.text = "del"
			editorbox.add_child(delbtn)
			delbtn.pressed.connect(del_button_pressed.bind(i))
		

		if value_type == TYPE_PACKED_BYTE_ARRAY:
			editor.get_spinbox().min_value = 0
			editor.get_spinbox().max_value = 255
		elif value_type == TYPE_PACKED_INT32_ARRAY:
			editor.get_spinbox().min_value = -0x80000000
			editor.get_spinbox().max_value = 0x7fffffff
		
		
		editor.value = arval

func del_button_pressed(idx):
	value.remove_at(idx)
	__setup_value()


func _on_button_toggled(button_pressed):$PanelContainer.visible = button_pressed


func _on_size_spin_down_value_changed(new_size):
	value.resize(new_size)
	__setup_value()

func _on_new_ele_button_pressed():
	value.append(HPTEditorUtil.get_type_default_val(get_static_type_info()) )
	__setup_value()
	


func sub_editor_modified(new_val,idx):
	editing = true
	value[idx] = new_val
	value_changed.emit(value)
	editing = false
	

func type_value_changed(new_type, idx:int):
	if new_type == 0xffff:
		value.remove_at(idx)
		__setup_value()
		return

	var old_value = value[idx]
	var old_type = typeof(old_value)
	var new_value = HPTEditorUtil.get_type_default_val(new_type)
	
	if HPTEditorUtil.can_be_conv_to_num(old_type):
		if new_type == TYPE_INT:new_value = int(old_value)
		if new_type == TYPE_FLOAT:new_value = float(old_value)
	if HPTEditorUtil.can_be_conv_to_vec2num(old_type):
		if new_type == TYPE_VECTOR2I:new_value = Vector2i(old_value)
		if new_type == TYPE_VECTOR2:new_value = Vector2(old_value)
	if HPTEditorUtil.can_be_conv_to_vec3num(old_type):
		if new_type == TYPE_VECTOR3I:new_value = Vector3i(old_value)
		if new_type == TYPE_VECTOR3:new_value = Vector3(old_value)
	if HPTEditorUtil.can_be_conv_to_vec4num(old_type):
		if new_type == TYPE_VECTOR4I:new_value = Vector4i(old_value)
		if new_type == TYPE_VECTOR4:new_value = Vector4(old_value)	
	if HPTEditorUtil.can_be_conv_to_rec2num(old_type):
		if new_type == TYPE_RECT2I:new_value = Rect2i(old_value)
		if new_type == TYPE_RECT2:new_value = Rect2(old_value)
	


	value[idx] = new_value
	__setup_value()


func _on_array_size_value_changed(new_val: int) -> void:
	if value == null:return
	if new_val == value.size():return
	value.resize(new_val)
	__setup_value()
