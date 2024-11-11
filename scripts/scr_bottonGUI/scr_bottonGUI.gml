
function scr_bottonGUI_create(_name = "meow", _x, _y, _w, _h, _icon=pointer_null,_function=function(){show_message("botton presionado")}){
	return {
		name		: _name,
		x			: _x,
		y			: _y,
		w			: _w,
		h			: _h,
		Function	: _function,
		point_mouse : false,
		select		: false,
		sum_select  : false,
		icon		: _icon
	}
}

function scr_bottonGUI_step(_bottonGUI_id){
	var b = _bottonGUI_id;
	var _mx = mouse_x;
	var _my = mouse_y;
	
	var point = point_in_rectangle(_mx, _my, b.x - (b.w/2), b.y - (b.h/2), b.x + (b.w/2), b.y + (b.h/2));
	
	if (point){
		b.point_mouse = true;
		global.bottongui_point++;
		}
	else b.point_mouse = false;	
	
	if (variable_global_exists("pincel"))
		b.select = (global.pincel == b.name)
	
	b.sum_select = sign(b.point_mouse + b.select);
	
	
	
	if (b.point_mouse){
		if (mouse_check_button_released(mb_left))
		script_execute(b.Function);
	}
	
	return b;
}

function scr_bottonGUI_get_fromMouse(){
	return sign(global.bottongui_point);
}

function scr_bottonGUI_draw(_bottonGUI_id){
	var b = _bottonGUI_id;
	
	var _mouse_press = mouse_check_button(mb_left) * b.point_mouse;
	var _color_prest	= c_blue 
	var _color_point	= c_black
	var _color_despoint	= c_white
	
	
	
	draw_set_color((b.sum_select)? ( _mouse_press ? _color_prest : _color_point) : _color_despoint );
	draw_roundrect(b.x - (b.w/2), b.y - (b.h/2), b.x + (b.w/2), b.y + (b.h/2), false);
	draw_set_color((b.sum_select)? _color_despoint : _color_point );
	draw_roundrect(b.x - (b.w/2), b.y - (b.h/2), b.x + (b.w/2), b.y + (b.h/2), true);
	
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
		draw_text(b.x, b.y-(b.w/3), b.name);
		
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	
	if (b.icon != pointer_null)
		draw_sprite_stretched_ext(b.icon,0,b.x-(b.w/16),b.y-(b.w/16), (b.w/3), (b.w/3), c_white, 1);

	draw_set_color(c_white);
}

/// @desc Creates a new scroll GUI element
/// @param {String} _name="color" Name of the GUI element
/// @param {Real} _x X position
/// @param {Real} _y Y position
/// @param {Real} _initial_val=0.5 Initial value (0-1)
/// @param {Real} _w=255 Width of the slider
/// @param {Real} _h=32 Height of the slider
function scr_scrollGUI_create(_name = "color", _x, _y, _initial_val = 0.5, _w = 255, _h = 32) {
    // Clamp initial value between 0 and 1
    _initial_val = clamp(_initial_val, 0, 1);
    
    // Calculate initial slider position based on initial value
    var initial_offset = _w * _initial_val;
    
    return {
        name: _name,
        x: _x,
        y: _y,
        w: _w,
        h: _h,
        
        x1: _x - (_w / 2),
        x2: _x + (_w / 2),
        // Convert initial value to slider position
        val: -initial_offset,
        select: false,
        
        // Added properties for better control
        min_val: 0,
        max_val: 255,
        step: 1
    };
}

/// @desc Updates the scroll GUI element
/// @param {Struct} _scrollGUI_id The GUI element to update
function scr_scrollGUI_step(_scrollGUI_id) {
    var s = _scrollGUI_id;
    
    // Update boundaries
    s.x1 = s.x - (s.w / 2);
    s.x2 = s.x + (s.w / 2);
    var _mx = mouse_x;
	var _my = mouse_y;
	show_debug_message(string(s.x1)+"-"+string(s.x2)+"-"+string(s.y)+"-"+string(s.h)+"-")
    // Check for mouse interaction
    var point = point_in_rectangle(_mx, _my, s.x1, s.y, s.x2, s.y + s.h);
    
    if (point && mouse_check_button_pressed(mb_left)) {
        s.select = true;
    }
    
    if (mouse_check_button_released(mb_left)) {
        s.select = false;
    }
    
    // Update value when selected
    if (s.select) {
        var mouse_val = clamp(mouse_x, s.x1, s.x2);
        s.val = s.x1 - mouse_val;
        // Normalize value between min_val and max_val
        s.val = clamp(s.val, -s.w, 0);
        
        // Set global GUI focus
        global.bottongui_point = 100;
    }
    
    return s;
}

/// @desc Draws the scroll GUI element
/// @param {Struct} _scrollGUI_id The GUI element to draw
function scr_scrollGUI_draw(_scrollGUI_id, input = false, _type = TYPEGUI_TEXTO, _step=1, _id_shd = 0, _val_shd = 0) {
    var s = _scrollGUI_id;
    
    // Draw slider background
	
	shader_set(shd_bar);
		shader_set_uniform_i(shader_get_uniform(shd_bar,"_var"), _id_shd);
		shader_set_uniform_f(shader_get_uniform(shd_bar,"color_base"), abs(_val_shd) );
		draw_sprite_stretched(spr_tex_bar,0,s.x1,s.y,s.w,s.h);
	shader_reset()
	//draw_rectangle(s.x1, s.y, s.x2, s.y + s.h, false);
    
    // Draw slider border
    draw_set_color(c_white);
    draw_rectangle(s.x1, s.y, s.x2, s.y + s.h, true);
	
	draw_set_halign(fa_right)
		draw_text(s.x2-4,s.y, s.name);
	draw_set_halign(fa_left)
	
    
    // Draw slider handle
    draw_circle(s.x1 - s.val, s.y + s.h/2, s.h/2, false);
    draw_set_color(c_black);
    draw_circle(s.x1 - s.val, s.y + s.h/2, s.h/2, true);
    
    // Reset color
    draw_set_color(c_white);
	
	if (input){
		scr_inputGUI_draw(_type,-s.val/s.w, _step,s.x2+32,s.y+(s.h),32,32);
	}
}




/// @desc Gets the current value of the slider normalized between 0 and 1
/// @param {Struct} _scrollGUI_id The GUI element
function scr_scrollGUI_get_value(_scrollGUI_id) {
    var s = _scrollGUI_id;
    return (-s.val / s.w);
}
	
	
#macro TYPEGUI_COLOR 0
#macro TYPEGUI_TEXTO 1

function scr_inputGUI_draw(_typeGUI, val = pointer_null, _step=1, _x, _y, _w=32, _h=32){
	if (_typeGUI == TYPEGUI_COLOR){
		draw_set_color(make_color_hsv(val[0]*255, val[1]*255, val[2]*255))
			draw_roundrect(_x-_w,_y-_h,_x+_w,_y+_h, false);
		draw_set_color(c_white);
		draw_roundrect(_x-_w,_y-_h,_x+_w,_y+_h, true);
	} else if (TYPEGUI_TEXTO){
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
			draw_text(_x, _y-(_w/3), val * _step);
		
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	}
}