if (mouse_wheel_up())	cam_zoom = clamp(cam_zoom-cam_zoom_step, cam_zoom_min, cam_zoom_max);
if (mouse_wheel_down())	cam_zoom = clamp(cam_zoom+cam_zoom_step, cam_zoom_min, cam_zoom_max);



var cam_w = window_get_width()	* cam_zoom;
var cam_h = window_get_height()	* cam_zoom;

var _vrfc_A = (obj_canvas_main.pincel.type == PINCEL_MANO);

if (((mouse_check_button_pressed(mb_left) * _vrfc_A || keyboard_check_pressed(ord("H"))) and !obj_buttons.btt_gui_from_mouse) || mouse_check_button_pressed(mb_middle)){
	point_prex = device_mouse_x_to_gui(0);
	point_prey = device_mouse_y_to_gui(0);
	cam_x_actual = cam_x;
	cam_y_actual = cam_y;
}
if (((mouse_check_button(mb_left) * _vrfc_A || keyboard_check(ord("H"))) and !obj_buttons.btt_gui_from_mouse) || mouse_check_button(mb_middle)){
	point_x = device_mouse_x_to_gui(0);
	point_y = device_mouse_y_to_gui(0);
}

cam_x = clamp(cam_x_actual - ((point_x - point_prex) * cam_zoom), cam_w/2, room_width  - (cam_w/2));
cam_y = clamp(cam_y_actual - ((point_y - point_prey) * cam_zoom), cam_h/2, room_height - (cam_h/2));

camera = camera_create_view(0,0, cam_w, cam_h, 0, self, -1, -1, cam_w/2, cam_h/2);
view_camera[0] = camera


x = cam_x;
y = cam_y;

show_debug_message( [ cam_x, cam_y])