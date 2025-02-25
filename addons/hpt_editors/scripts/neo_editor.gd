@tool
class_name NeoEditor
## Base Class extended by all custom property editors
## you're probably looking for the other classes which are in the scripts folder
## but you should actually use the scenes instead. 

extends Control

## does what it says on the tin, it notifies if the value changed
signal value_changed(new_val)
## the name displayed on the Label, it can be changed at any time
@export var prop_name :String: set=__set_prop_name
## DO NOT SET THIS VALUE BEFORE ADDING THE NODE AS A CHILD
## VALUE GETS SET AT _ready() by the __set_initial() func
## setup AFTER adding the node to the scenetree
var value :set=__set_value



func __set_value(v):
	value = v
	__setup_value()
	value_changed.emit(value)

func __set_prop_name(v):
	prop_name = v
	if not is_inside_tree():return self
	%Label.text = v
	return self	

func __set_initial():pass
func __setup_value():pass

## override if the value requires a hint string like the enum/flag editors for example.
func setup_hintstr(hintstr:String):pass


func _ready() -> void:
	__set_initial()
	__setup_value()
	__set_prop_name(prop_name)
