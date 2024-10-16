extends Node3D

# The current page is the one on the left
var current_page_number = 1

# This is displayed when pages are not moving
@onready var static_page = $Book/Static
# This is displayed when pages are moving
@onready var turning_page = $Book/Turning
@onready var turning_animation = $Book/Turning/AnimationPlayer

# Pages when turning: left, animated side 1, animated side 2, right
@onready var pf1 = $Book/Turning/PageLeft
@onready var pf2 = $Book/Turning/Page/Skeleton3D/Front
@onready var pf3 = $Book/Turning/Page/Skeleton3D/Back
@onready var pf4 = $Book/Turning/PageRight


# Pages when static: left, right
@onready var ps1 = $Book/Static/PageLeft
@onready var ps2 = $Book/Static/PageRight

# There are 6 viewports. Current page (left) is v3, to its right is v4.
# Moreover, there are 2 pages before (v1, v2) and after (v5, v6)
@onready var v1 = $Viewport1
@onready var v2 = $Viewport2
@onready var v3 = $Viewport3
@onready var v4 = $Viewport4
@onready var v5 = $Viewport5
@onready var v6 = $Viewport6

@onready var sfx : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animationPlayer : AnimationPlayer = $Book/Turning/AnimationPlayer

func _ready():
	update_page_number()
	turning_page.hide()
	set_texture(ps1, v3)
	set_texture(ps2, v4)
	
	animationPlayer.animation_finished.connect(_on_animation_finished)


func _input(_event):
	if turning_animation.is_playing():
		return
	if Input.is_action_just_pressed("ui_left"):
		turn_left()
	if Input.is_action_just_pressed("ui_right"):
		turn_right()


func turn_right():
	set_texture(pf1, v3)
	set_texture(pf2, v4)
	set_texture(pf3, v5)
	set_texture(pf4, v6)
	
	
	hide_and_show(pf4)
	
	static_page.hide()
	turning_page.show()
	turning_animation.play("Turn1")
	sfx.play()


func turn_left():
	if current_page_number <= 1:
		return
		
	set_texture(pf1, v1)
	set_texture(pf2, v2)
	set_texture(pf3, v3)
	set_texture(pf4, v4)
	hide_and_show(pf1)
	turning_page.show()
	static_page.hide()
	turning_animation.play("Turn2")
	sfx.play()
	
	
func hide_and_show(page : Node):
	page.hide()  # Hide the node immediately
	await get_tree().create_timer(0.1).timeout  # Wait for 0.1 seconds
	page.show()  # Show the node again


func update_page_number(page_offset = 0):
	"""Changes current page's number by the offset and updates the viewports."""
	current_page_number += page_offset
	var number_offset = -2
	for v in [v1, v2, v3, v4, v5, v6]:
		v.get_node("Page").set_number(current_page_number + number_offset)
		number_offset += 1


func set_texture(page, viewport):
	"""Attaches a viewport texture to a page."""
	page.material_override = StandardMaterial3D.new()
	page.material_override.albedo_texture = viewport.get_texture()


func _on_animation_finished(anim_name):
	if anim_name == "Turn1":
		update_page_number(2)
	if anim_name == "Turn2":
		update_page_number(-2)
	static_page.show()
	turning_page.hide()
