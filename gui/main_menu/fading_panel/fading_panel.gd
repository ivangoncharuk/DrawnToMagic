extends Panel

var style = StyleBoxFlat.new()
var start_time: int = Time.get_ticks_msec()
var bg_color : Color

var color_palette : Array[Color] = [
	Color(1.0, 0.0, 0.0),  # Red
	Color(1.0, 1.0, 0.0),  # Yellow
	Color(0.0, 1.0, 0.0),  # Green
	Color(0.0, 1.0, 1.0),  # Cyan
	Color(0.0, 0.0, 1.0),  # Blue
	Color(1.0, 0.0, 1.0)   # Magenta
]


var color_palette_transparent : Array[Color] = apply_alpha_to_palette(color_palette, 0.3)


func _ready() -> void:
	add_theme_stylebox_override("panel", style)
	style.skew = Vector2(-0.2, 0.1)
	style.corner_detail = 2
	style.set_corner_radius_all(20)
	style.set_border_width_all(2)
	style.border_color = Color.html("#cccccc")
	style.border_blend = true
	set_process(true)


func _process(_delta: float) -> void:
	var elapsed_time = Time.get_ticks_msec() - start_time
	var elapsed_seconds = elapsed_time / 1000
	var phase = elapsed_seconds % 10  # Calculate the phase of the animation (10 seconds per cycle)
	var index = int(phase / 10.0 * len(color_palette_transparent)) # Calculate the index of the color to use
	bg_color = color_palette_transparent[index]  # Get the color from the palette

	# this will animate the color change smoothly
	var transition_speed = 0.05
	var current_color = style.get_bg_color()
	bg_color = current_color.lerp(bg_color, transition_speed)
	style.set_bg_color(bg_color)
	force_update_transform()


func apply_alpha_to_palette(palette: Array[Color], alpha: float) -> Array[Color]:
	var new_palette: Array[Color] = []
	for color in palette:
		var new_color = Color(color.r, color.g, color.b, alpha)
		new_palette.append(new_color)
	return new_palette
