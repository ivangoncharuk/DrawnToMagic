extends Control

@onready var draw_surface: DrawSurface = $DrawSurface
@onready var result_label: Label = %Result

var recognizer := GestureRecognizer.new()

## Add one predefined point-cloud for each gesture.
var predefined_point_cloud: Dictionary = {
	"T":
	[
		GesturePoint.new(30, 7, 1),
		GesturePoint.new(103, 7, 1),
		GesturePoint.new(66, 7, 2),
		GesturePoint.new(66, 87, 2)
	],
	"N":
	[
		GesturePoint.new(177, 92, 1),
		GesturePoint.new(177, 2, 1),
		GesturePoint.new(182, 1, 2),
		GesturePoint.new(246, 95, 2),
		GesturePoint.new(247, 87, 3),
		GesturePoint.new(247, 1, 3)
	],
	"D":
	[
		GesturePoint.new(345, 9, 1),
		GesturePoint.new(345, 87, 1),
		GesturePoint.new(351, 8, 2),
		GesturePoint.new(363, 8, 2),
		GesturePoint.new(372, 9, 2),
		GesturePoint.new(380, 11, 2),
		GesturePoint.new(386, 14, 2),
		GesturePoint.new(391, 17, 2),
		GesturePoint.new(394, 22, 2),
		GesturePoint.new(397, 28, 2),
		GesturePoint.new(399, 34, 2),
		GesturePoint.new(400, 42, 2),
		GesturePoint.new(400, 50, 2),
		GesturePoint.new(400, 56, 2),
		GesturePoint.new(399, 61, 2),
		GesturePoint.new(397, 66, 2),
		GesturePoint.new(394, 70, 2),
		GesturePoint.new(391, 74, 2),
		GesturePoint.new(386, 78, 2),
		GesturePoint.new(382, 81, 2),
		GesturePoint.new(377, 83, 2),
		GesturePoint.new(372, 85, 2),
		GesturePoint.new(367, 86, 2),
		GesturePoint.new(360, 87, 2),
		GesturePoint.new(355, 87, 2),
		GesturePoint.new(349, 86, 2)
	],
	"P":
	[
		GesturePoint.new(507, 8, 1),
		GesturePoint.new(507, 87, 1),
		GesturePoint.new(513, 7, 2),
		GesturePoint.new(528, 7, 2),
		GesturePoint.new(537, 8, 2),
		GesturePoint.new(544, 10, 2),
		GesturePoint.new(550, 12, 2),
		GesturePoint.new(555, 15, 2),
		GesturePoint.new(558, 18, 2),
		GesturePoint.new(560, 22, 2),
		GesturePoint.new(561, 27, 2),
		GesturePoint.new(562, 33, 2),
		GesturePoint.new(561, 37, 2),
		GesturePoint.new(559, 42, 2),
		GesturePoint.new(556, 45, 2),
		GesturePoint.new(550, 48, 2),
		GesturePoint.new(544, 51, 2),
		GesturePoint.new(538, 53, 2),
		GesturePoint.new(532, 54, 2),
		GesturePoint.new(525, 55, 2),
		GesturePoint.new(519, 55, 2),
		GesturePoint.new(513, 55, 2),
		GesturePoint.new(510, 55, 2)
	],
	"X":
	[
		GesturePoint.new(30, 146, 1),
		GesturePoint.new(106, 222, 1),
		GesturePoint.new(30, 225, 2),
		GesturePoint.new(106, 146, 2)
	],
	"H":
	[
		GesturePoint.new(188, 137, 1),
		GesturePoint.new(188, 225, 1),
		GesturePoint.new(188, 180, 2),
		GesturePoint.new(241, 180, 2),
		GesturePoint.new(241, 137, 3),
		GesturePoint.new(241, 225, 3)
	],
	"I":
	[
		GesturePoint.new(371, 149, 1),
		GesturePoint.new(371, 221, 1),
		GesturePoint.new(341, 149, 2),
		GesturePoint.new(401, 149, 2),
		GesturePoint.new(341, 221, 3),
		GesturePoint.new(401, 221, 3)
	],
	"exclamation":
	[
		GesturePoint.new(526, 142, 1),
		GesturePoint.new(526, 204, 1),
		GesturePoint.new(526, 221, 2)
	],
	"line": [GesturePoint.new(12, 347, 1), GesturePoint.new(119, 347, 1)],
	"five-point star":
	[
		GesturePoint.new(177, 396, 1),
		GesturePoint.new(223, 299, 1),
		GesturePoint.new(262, 396, 1),
		GesturePoint.new(168, 332, 1),
		GesturePoint.new(278, 332, 1),
		GesturePoint.new(184, 397, 1)
	],
	"null":
	[
		GesturePoint.new(382, 310, 1),
		GesturePoint.new(377, 308, 1),
		GesturePoint.new(373, 307, 1),
		GesturePoint.new(366, 307, 1),
		GesturePoint.new(360, 310, 1),
		GesturePoint.new(356, 313, 1),
		GesturePoint.new(353, 316, 1),
		GesturePoint.new(349, 321, 1),
		GesturePoint.new(347, 326, 1),
		GesturePoint.new(344, 331, 1),
		GesturePoint.new(342, 337, 1),
		GesturePoint.new(341, 343, 1),
		GesturePoint.new(341, 350, 1),
		GesturePoint.new(341, 358, 1),
		GesturePoint.new(342, 362, 1),
		GesturePoint.new(344, 366, 1),
		GesturePoint.new(347, 370, 1),
		GesturePoint.new(351, 374, 1),
		GesturePoint.new(356, 379, 1),
		GesturePoint.new(361, 382, 1),
		GesturePoint.new(368, 385, 1),
		GesturePoint.new(374, 387, 1),
		GesturePoint.new(381, 387, 1),
		GesturePoint.new(390, 387, 1),
		GesturePoint.new(397, 385, 1),
		GesturePoint.new(404, 382, 1),
		GesturePoint.new(408, 378, 1),
		GesturePoint.new(412, 373, 1),
		GesturePoint.new(416, 367, 1),
		GesturePoint.new(418, 361, 1),
		GesturePoint.new(419, 353, 1),
		GesturePoint.new(418, 346, 1),
		GesturePoint.new(417, 341, 1),
		GesturePoint.new(416, 336, 1),
		GesturePoint.new(413, 331, 1),
		GesturePoint.new(410, 326, 1),
		GesturePoint.new(404, 320, 1),
		GesturePoint.new(400, 317, 1),
		GesturePoint.new(393, 313, 1),
		GesturePoint.new(392, 312, 1),
		GesturePoint.new(418, 309, 2),
		GesturePoint.new(337, 390, 2)
	],
	"arrowhead":
	[
		GesturePoint.new(506, 349, 1),
		GesturePoint.new(574, 349, 1),
		GesturePoint.new(525, 306, 2),
		GesturePoint.new(584, 349, 2),
		GesturePoint.new(525, 388, 2)
	],
	"pitchfork":
	[
		GesturePoint.new(38, 470, 1),
		GesturePoint.new(36, 476, 1),
		GesturePoint.new(36, 482, 1),
		GesturePoint.new(37, 489, 1),
		GesturePoint.new(39, 496, 1),
		GesturePoint.new(42, 500, 1),
		GesturePoint.new(46, 503, 1),
		GesturePoint.new(50, 507, 1),
		GesturePoint.new(56, 509, 1),
		GesturePoint.new(63, 509, 1),
		GesturePoint.new(70, 508, 1),
		GesturePoint.new(75, 506, 1),
		GesturePoint.new(79, 503, 1),
		GesturePoint.new(82, 499, 1),
		GesturePoint.new(85, 493, 1),
		GesturePoint.new(87, 487, 1),
		GesturePoint.new(88, 480, 1),
		GesturePoint.new(88, 474, 1),
		GesturePoint.new(87, 468, 1),
		GesturePoint.new(62, 464, 2),
		GesturePoint.new(62, 571, 2)
	],
	"six-point star":
	[
		GesturePoint.new(177, 554, 1),
		GesturePoint.new(223, 476, 1),
		GesturePoint.new(268, 554, 1),
		GesturePoint.new(183, 554, 1),
		GesturePoint.new(177, 490, 2),
		GesturePoint.new(223, 568, 2),
		GesturePoint.new(268, 490, 2),
		GesturePoint.new(183, 490, 2)
	],
	"asterisk":
	[
		GesturePoint.new(325, 499, 1),
		GesturePoint.new(417, 557, 1),
		GesturePoint.new(417, 499, 2),
		GesturePoint.new(325, 557, 2),
		GesturePoint.new(371, 486, 3),
		GesturePoint.new(371, 571, 3)
	],
	"half-note":
	[
		GesturePoint.new(546, 465, 1),
		GesturePoint.new(546, 531, 1),
		GesturePoint.new(540, 530, 2),
		GesturePoint.new(536, 529, 2),
		GesturePoint.new(533, 528, 2),
		GesturePoint.new(529, 529, 2),
		GesturePoint.new(524, 530, 2),
		GesturePoint.new(520, 532, 2),
		GesturePoint.new(515, 535, 2),
		GesturePoint.new(511, 539, 2),
		GesturePoint.new(508, 545, 2),
		GesturePoint.new(506, 548, 2),
		GesturePoint.new(506, 554, 2),
		GesturePoint.new(509, 558, 2),
		GesturePoint.new(512, 561, 2),
		GesturePoint.new(517, 564, 2),
		GesturePoint.new(521, 564, 2),
		GesturePoint.new(527, 563, 2),
		GesturePoint.new(531, 560, 2),
		GesturePoint.new(535, 557, 2),
		GesturePoint.new(538, 553, 2),
		GesturePoint.new(542, 548, 2),
		GesturePoint.new(544, 544, 2),
		GesturePoint.new(546, 540, 2),
		GesturePoint.new(546, 536, 2)
	]
}

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_ENTER:
			var result := recognizer.recognize(draw_surface.get_points())
			print_debug(result.name, " ", result.score, " ", result.time)
			result_label.text = str(result.name)
			draw_surface.clear()

func _ready() -> void:
	for template in predefined_point_cloud:
		var points: Array[GesturePoint] = []
		points.assign(predefined_point_cloud[template])
		recognizer.add_gesture(template, points)
