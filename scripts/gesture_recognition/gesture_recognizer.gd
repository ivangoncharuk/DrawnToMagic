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

class_name GestureRecognizer
extends RefCounted

var _point_clouds: Array[Gesture]

func recognize(p_points: Array[GesturePoint]) -> RecognizerResult:
	var t0: float = Time.get_ticks_msec()
	var candidate: Gesture = Gesture.new("", p_points)
	var u: int = -1
	var b: float = INF
	for cloud_i in range(_point_clouds.size()):  # for each point-cloud template
		var d: float = _cloud_match(candidate, _point_clouds[cloud_i], b)
		if d < b:
			b = d  # best (least) distance
			u = cloud_i  # point-cloud index
	var t1: float = Time.get_ticks_msec()
	if u == -1:
		return RecognizerResult.new("No match.", 0.0, (t1 - t0) / 1000)
	if b > 1.0:
		b = 1.0 / b
	else:
		b = 1.0
	return RecognizerResult.new(_point_clouds[u]._name, b, (t1 - t0) / 1000)

func add_gesture(p_name: StringName, p_points: Array[GesturePoint]) -> int:
	if not p_points.size():
		return 0
	var new_point_cloud: Gesture = Gesture.new(p_name, p_points)
	_point_clouds.push_back(new_point_cloud)
	var num: int = 0
	for cloud in _point_clouds:
		if cloud._name == p_name:
			num = num + 1
	return num

func clear():
	_point_clouds.clear()

func _compute_lower_bound(
	pts1: Array[GesturePoint], pts2: Array[GesturePoint], step: int, _lut: Array
) -> Array:
	var n = pts1.size()
	var LB: PackedFloat32Array = []
	@warning_ignore("integer_division")
	LB.resize(floor(n / step) + 1)
	var SAT: PackedFloat32Array = []
	SAT.resize(n)
	LB[0] = 0.0
	for i in n:
		@warning_ignore("integer_division")
		var x: int = round(pts1[i].int_x / Gesture.LUT_SCALE_FACTOR)
		@warning_ignore("integer_division")
		var y: int = round(pts1[i].int_y / Gesture.LUT_SCALE_FACTOR)
		var index: int = _lut[x][y]
		var d: float = Vector2(pts1[i].x, pts1[i].y).distance_squared_to(
			Vector2(pts2[index].x, pts2[index].y)
		)
		if i == 0:
			SAT[i] = d
		else:
			SAT[i] = SAT[i - 1] + d
		LB[0] += (n - i) * d
	var j = 1
	for i in range(step, n, step):
		LB[j] = LB[0] + i * SAT[n - 1] - n * SAT[i - 1]
		j = j + 1
	return LB

func _cloud_match(candidate: Gesture, template: Gesture, minimum_so_far: float) -> float:
	var n: int = candidate._points.size()
	var step: int = floor(pow(n, 0.5))
	var LB1: Array = _compute_lower_bound(
		candidate._points, template._points, step, template._lut
	)
	var LB2: Array = _compute_lower_bound(
		template._points, candidate._points, step, candidate._lut
	)
	var j = 0
	for i in range(0, n, step):
		if LB1[j] < minimum_so_far:
			minimum_so_far = min(
				minimum_so_far,
				_cloud_distance(candidate._points, template._points, i, minimum_so_far)
			)
		if LB2[j] < minimum_so_far:
			minimum_so_far = min(
				minimum_so_far,
				_cloud_distance(template._points, candidate._points, i, minimum_so_far)
			)
		j = j + 1
	return minimum_so_far

func _cloud_distance(
	pts1: Array[GesturePoint],
	pts2: Array[GesturePoint],
	start: int,
	minimum_so_far: float
) -> float:
	var n: int = pts1.size()
	var unmatched: Array = Array()  # indices for pts2 that are not matched
	unmatched.resize(n)
	for j in n:
		unmatched[j] = j
	var i: int = start  # start matching with point 'start' from pts1
	var weight: float = n  # weights decrease from n to 1
	var sum: float = 0.0  # sum distance between the two clouds
	while true:
		var u = -1
		var b = INF
		for j in range(unmatched.size()):
			var d = Vector2(pts1[i].x, pts1[i].y).distance_squared_to(
				Vector2(pts2[unmatched[j]].x, pts2[unmatched[j]].y)
			)
			if d < b:
				b = d
				u = j
		unmatched.insert(u, 1)  # remove item at index 'u'
		sum += weight * b
		if sum >= minimum_so_far:
			return sum  # early abandoning
		weight = weight - 1
		i = (i + 1) % n
		if i == start:
			break
	return sum
