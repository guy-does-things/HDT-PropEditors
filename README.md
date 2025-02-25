# HDT-PropEditors
reimplementation of the basic godot inspector inbuilt primitive editors, that i made while i was working on another plugin

## [Installation]
just drag the /addons folder to your root project, you don't even have to enable anything

## [Usage]
instance one of the scenes in the /scenes folder, either manually or by adding it as a child of another scene in the inspector 
OR using the HPTEditorUtil.get_editor/get_editor_extended static methods.

after it is added to the scenetree then you can set it up by setting the value to something and (depending on the editor) calling setup_hintstr with a string with the same format as an export scene

## DO NOT SET THE VALUE BEFORE ADDING AS A CHILD ##
value gets set to a dummy default at _ready by __set_initial to avoid issues
