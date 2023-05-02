# * This software is distributed under the "New BSD License" agreement:
# *
# * Copyright (c) 2018-2019, Nathan Magrofuoco, Jacob O. Wobbrock, Radu-Daniel Vatavu,
# * and Lisa Anthony. All rights reserved.
# *
# * Redistribution and use in source and binary forms, with or without
# * modification, are permitted provided that the following conditions are met:
# *    * Redistributions of source code must retain the above copyright
# *      notice, this list of conditions and the following disclaimer.
# *    * Redistributions in binary form must reproduce the above copyright
# *      notice, this list of conditions and the following disclaimer in the
# *      documentation and/or other materials provided with the distribution.
# *    * Neither the names of the University Stefan cel Mare of Suceava,
# *      University of Washington, nor University of Florida, nor the names of its
# *      contributors may be used to endorse or promote products derived from this
# *      software without specific prior written permission.
# *
# * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Radu-Daniel Vatavu OR Lisa Anthony
# * OR Jacob O. Wobbrock BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# * SUCH DAMAGE.
#**/

# Credit to V-Sekai for Godot implementation
# https://github.com/V-Sekai/godot-point-cloud-multistroke-recognizer/tree/main

class_name Gesture
extends Resource

const NUMBER_POINTS = 32
const MAX_INTEGER_COORDINATE = 1024  # (IntX, IntY) range from [0, MAX_INTEGER_COORDINATE - 1]
const LUT_SIZE = 64  # default size of the lookup table is 64 x 64
@warning_ignore("integer_division") 
const LUT_SCALE_FACTOR = MAX_INTEGER_COORDINATE / LUT_SIZE  # used to scale from (IntX, IntY) to LUT

var _name: StringName = ""
var _points: Array[GesturePoint] = []
var _origin: GesturePoint = GesturePoint.new(0, 0, 0)
var _lut: Array = []


func _init(p_name: StringName, p_points: Array[GesturePoint]):
	_name = p_name
	_points = p_points
	_points = resample(_points, NUMBER_POINTS)
	_points = scale(_points)
	_points = translate_to(_points, _origin)
	_points = _make_integer_coordinates(_points)  # fills in (IntX, IntY) values
	_lut = _compute_lut(_points)


func scale(points: Array[GesturePoint]) -> Array[GesturePoint]:
	var minX: float = INF
	var maxX: float = -INF
	var minY: float = INF
	var maxY: float = -INF
	for point in points:
		minX = min(minX, point.x)
		minY = min(minY, point.y)
		maxX = max(maxX, point.x)
		maxY = max(maxY, point.y)
	var size: float = max(maxX - minX, maxY - minY)
	var newpoints: Array[GesturePoint] = []
	for point in points:
		var qx = (point.x - minX) / size
		var qy = (point.y - minY) / size
		newpoints.push_back(GesturePoint.new(qx, qy, point.id))
	return newpoints


func centroid(points) -> GesturePoint:
	var x: float = 0.0
	var y: float = 0.0
	for point in points:
		x += point.x
		y += point.y
	x /= points.size()
	y /= points.size()
	return GesturePoint.new(x, y, 0)


func translate_to(points: Array[GesturePoint], pt: GesturePoint) -> Array[GesturePoint]:  # translates points' centroid to points
	var c = centroid(points)
	var newpoints: Array[GesturePoint] = []
	newpoints.resize(points.size())
	for point_i in range(points.size()):
		var point = points[point_i]
		var qx = point.x + pt.x - c.x
		var qy = point.y + pt.y - c.y
		newpoints[point_i] = GesturePoint.new(qx, qy, point.id)
	return newpoints


func path_length(points: Array[GesturePoint]) -> float:  # length traversed by a point path
	if points.size() < 2:
		return 0.0
	var d: float = 0.0
	for point_i in range(1, points.size()):
		if points[point_i].id == points[point_i - 1].id:
			d += Vector2(points[point_i - 1].x, points[point_i - 1].y).distance_to(
				Vector2(points[point_i].x, points[point_i].y)
			)
	return d


func resample(p_points: Array[GesturePoint], n: int) -> Array[GesturePoint]:
	var I = path_length(p_points) / (n - 1)  # interval length
	var D = 0.0
	var new_points: Array[GesturePoint] = []
	new_points.resize(n)
	new_points.fill(p_points[0])
	for point_i in range(1, n):
		if p_points[point_i].id == p_points[point_i - 1].id:
			var d = Vector2(p_points[point_i - 1].x, p_points[point_i - 1].y).distance_to(
				Vector2(p_points[point_i].x, p_points[point_i].y)
			)
			if (D + d) >= I:
				var qx = (
					p_points[point_i - 1].x
					+ ((I - D) / d) * (p_points[point_i].x - p_points[point_i - 1].x)
				)
				var qy = (
					p_points[point_i - 1].y
					+ ((I - D) / d) * (p_points[point_i].y - p_points[point_i - 1].y)
				)
				var q = GesturePoint.new(qx, qy, p_points[point_i].id)
				new_points[point_i] = q
				p_points.insert(point_i, q)  # insert 'q' at position i in points s.t. 'q' will be the next i
				D = 0.0
			else:
				D += d
	if new_points.size() == n - 1:  # Sometimes we fall a rounding-error short of adding the last point, so add it if so
		new_points.push_back(
			GesturePoint.new(
				p_points[p_points.size() - 1].x,
				p_points[p_points.size() - 1].y,
				p_points[p_points.size() - 1].id
			)
		)
	return new_points


func _make_integer_coordinates(points: Array[GesturePoint]) -> Array[GesturePoint]:
	for point in points:
		point.int_x = round((point.x + 1.0) / 2.0 * (MAX_INTEGER_COORDINATE - 1))
		point.int_y = round((point.y + 1.0) / 2.0 * (MAX_INTEGER_COORDINATE - 1))
	return points


func _compute_lut(points) -> Array:
	var _new_lut: Array = []
	_new_lut.resize(LUT_SIZE)
	for lut in LUT_SIZE:
		var lut_array: PackedFloat32Array = []
		lut_array.resize(LUT_SIZE)
		_new_lut[lut] = lut_array

	for x in LUT_SIZE:
		for y in LUT_SIZE:
			var u = -1
			var b = INF
			for points_i in range(points.size()):
				var row = round(points[points_i].int_x / LUT_SCALE_FACTOR)
				var col = round(points[points_i].int_y / LUT_SCALE_FACTOR)
				var d = ((row - x) * (row - x)) + ((col - y) * (col - y))
				if d < b:
					b = d
					u = points_i
			_new_lut[x][y] = u
	return _new_lut
