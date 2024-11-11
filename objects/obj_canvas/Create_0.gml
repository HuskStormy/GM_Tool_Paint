var _x = 32;
var _y = 72;
var _w = room_width	-_x;
var _h = room_height-_y;


// En el Create Event
surface_width = room_width	-(_x*2);
surface_height = room_height-(_y*2);
_draw_surface = -1;
is_drawing = false;
is_erasing = false;
previous_x = 0;
previous_y = 0;
brush_size = 20;
eraser_size = 10;
brush_color = c_white;

// Crear botón de guardado
save_button_x = 10;
save_button_y = 10;
save_button_width = 100;
save_button_height = 30;




function accion_drawing_pincel(){
	var _x = 32;
	var _y = 72;
	var _w = room_width	-_x;
	var _h = room_height-_y;
	
	draw_set_color(brush_color);
	    draw_line_width(
	        previous_x-_x, previous_y-_y,
	        mouse_x-_x, mouse_y-_y,
	        brush_size
	    );
		draw_circle(mouse_x-_x, mouse_y-_y, brush_size/2, false);
	draw_set_color(c_white);
}
function accion_drawing_borrador(){
	var _x = 32;
	var _y = 72;
	var _w = room_width	-_x;
	var _h = room_height-_y;
	
	
	draw_set_color(c_white);
	gpu_set_blendmode(bm_subtract);
		draw_line_width(
	        previous_x-_x, previous_y-_y,
	        mouse_x-_x, mouse_y-_y,
	        eraser_size
	    );
	draw_circle(mouse_x-_x, mouse_y-_y, eraser_size/2, false);
	gpu_set_blendmode(bm_normal);
}