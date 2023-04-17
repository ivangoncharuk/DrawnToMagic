extends CheckButton

func _ready():
	set_pressed_no_signal(Global.fullscreen)
	
	if !OS.has_feature("pc"):
		hide()
	
	self.connect("toggled", _on_fullscreen_toggled)


func _on_fullscreen_toggled(is_fullscreen : bool):
	Global.set_setting("fullscreen", is_fullscreen)
