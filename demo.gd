extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in TYPE_MAX:
	#	var i = TYPE_VECTOR3I
		if not HPTEditorUtil.is_valid_type(i):continue
		## setup for every other editor (add to tree before setting value, or else the inbuilt default value setter will win)
		var ed = HPTEditorUtil.get_editor(i)
		$ScrollContainer/VBoxContainer.add_child(ed)
		ed.prop_name = HPTEditorUtil.get_type_icon_name(i) +"Editor"
		ed.name = ed.prop_name		
		ed.value = HPTEditorUtil.get_type_default_val(i)
		ed.value_changed.connect(_on_editor_value_changed.bind(ed))

	## setup for every other editor (add to tree before setting value, or else the inbuilt default value setter will win)
	var fixar_ed = HPTEditorUtil.get_editor(TYPE_ARRAY)
	$ScrollContainer/VBoxContainer.add_child(fixar_ed)
	fixar_ed.prop_name = "Fixed"+HPTEditorUtil.get_type_icon_name(TYPE_ARRAY) +"Editor"
	fixar_ed.value = Array([],TYPE_BOOL,"",null)
	fixar_ed.value_changed.connect(_on_editor_value_changed.bind(fixar_ed))
	
		
	## flag/enum editor setup
	var enumed = HPTEditorUtil.get_editor_extended(TYPE_INT,PROPERTY_HINT_ENUM)
	$ScrollContainer/VBoxContainer.add_child(enumed)
	enumed.setup_hintstr("item 0,item 1,item 2,item 3")
	enumed.prop_name = "EnumEditor"
	enumed.value_changed.connect(_on_editor_value_changed.bind(enumed))
	
	enumed = HPTEditorUtil.get_editor_extended(TYPE_INT,PROPERTY_HINT_FLAGS)
	$ScrollContainer/VBoxContainer.add_child(enumed)
	enumed.setup_hintstr("bit 0,bit 1,bit 2,bit 3")
	enumed.prop_name = "EnumFlagsEditor"
	enumed.value_changed.connect(_on_editor_value_changed.bind(enumed))

func _on_editor_value_changed(val,editor):
	print(str("editor:",editor," type:",typeof(val)," value has changed to:",val))
