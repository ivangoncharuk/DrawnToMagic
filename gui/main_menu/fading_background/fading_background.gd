extends ColorRect

@onready var timer : Timer = $Timer

var start_time: int = Time.get_ticks_msec()

func _ready() -> void:
	timer.connect("timeout", _on_Timer_timeout)

var color_palette = [
	Color(1.0, 0.0, 0.0),  # Red
	Color(1.0, 1.0, 0.0),  # Yellow
	Color(0.0, 1.0, 0.0),  # Green
	Color(0.0, 1.0, 1.0),  # Cyan
	Color(0.0, 0.0, 1.0),  # Blue
	Color(1.0, 0.0, 1.0)   # Magenta
]

func _on_Timer_timeout() -> void:
	var tween = create_tween()
	var elapsed_time : int = Time.get_ticks_msec() - start_time
	var elapsed_seconds : int = elapsed_time / 1000
	var phase = elapsed_seconds % 10  # Calculate the phase of the animation (10 seconds per cycle)
	var index = int(phase / 10.0 * len(color_palette))  # Calculate the index of the color to use
	var new_color = color_palette[index]  # Get the color from the palette
	tween.tween_property(self, "color", new_color, 5).set_trans(Tween.TRANS_LINEAR)
