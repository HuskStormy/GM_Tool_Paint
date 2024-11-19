#region el canvas en blanco
	if (!surface_exists(surf_canvas)) {
	    surf_canvas = surface_create(surf_width, surf_height);
	    surface_set_target(surf_canvas);
	    draw_clear_alpha(c_white, .0);
	    surface_reset_target();
	}
#endregion

pincel.size = round(scroll_gui_get_value(obj_buttons.scr_pincel_size) * pincel.size_max);

var _c_hue = scroll_gui_get_value(obj_buttons.scr_pincel_HUE ) * 255;
var _c_sat = scroll_gui_get_value(obj_buttons.scr_pincel_SATR) * 255;
var _c_val = scroll_gui_get_value(obj_buttons.scr_pincel_VALU) * 255;
pincel.color = make_color_hsv(_c_hue, _c_sat, _c_val);



if (mouse.press and !obj_buttons.btt_gui_from_mouse){
	if (pincel.type == PINCEL_LAPIZ){
		surface_set_target(surf_canvas);
			draw_set_alpha(pincel.alpha);
			draw_set_color(pincel.color);
			    draw_line_width(
			        mouse.prex, mouse.prey,
			        mouse.x, mouse.y,
			        pincel.size
			    );
				draw_circle(mouse.prex, mouse.prey, pincel.size/2, false);
			draw_set_alpha(1);
			draw_set_color(c_white);
			
	
		surface_reset_target();
	}else if (pincel.type == PINCEL_BORRA){
		surface_set_target(surf_canvas);
			draw_set_color(c_white);
			draw_set_alpha(pincel.alpha);
			gpu_set_blendmode(bm_subtract);
				draw_line_width(
					mouse.prex, mouse.prey,
					mouse.x, mouse.y,
					pincel.size
				);
				draw_circle(mouse.prex, mouse.prey, pincel.size/2, false);
			gpu_set_blendmode(bm_normal);
			draw_set_alpha(1);
		surface_reset_target();
	}else if (pincel.type == PINCEL_CUBETA){
		//var _col	= my_get_color(surf_canvas, mouse.x, mouse.y);
		
		//instance_create_depth(mouse.x, mouse.y, 0, obj_pixelprog,{
		//	col		: _col[COL],	
		//	alpha	: _col[ALPHA],	
		//	blue	: _col[BLUE],
		//	green	: _col[GREED],
		//	red		: _col[RED],
		//	color_act : other.pincel.color
		//});
	}
	
}


display_set_gui_size(window_get_width(), window_get_height())