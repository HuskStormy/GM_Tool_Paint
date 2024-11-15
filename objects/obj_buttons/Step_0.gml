button_gui_step(btt_pincel_lapiz);
button_gui_step(btt_pincel_borra);
button_gui_step(btt_pincel_moveC);


var _scr_x = 0;
var _scr_y = 0;
var _scr_w = 32
var _bordo = 64;
var _y1 = _bordo;
var _y2 = display_get_gui_height() - _bordo;
var _scr_h = _y2 - _y1;

scroll_gui_set_position(scr_pincel_HUE ,_scr_x+_scr_w*00,_y1+(_scr_h/2)*00, _scr_w,_scr_h);
scroll_gui_set_position(scr_pincel_SATR,_scr_x+_scr_w*01,_y1+(_scr_h/2)*00, _scr_w,_scr_h/2);
scroll_gui_set_position(scr_pincel_VALU,_scr_x+_scr_w*01,_y1+(_scr_h/2)*01, _scr_w,_scr_h/2);


scroll_gui_step(scr_pincel_HUE);
scroll_gui_step(scr_pincel_SATR);
scroll_gui_step(scr_pincel_VALU);


scroll_gui_step(scr_pincel_size);













btt_gui_from_mouse = sign
	(
		button_gui_get_from_in_mouse(btt_pincel_lapiz) + 
		button_gui_get_from_in_mouse(btt_pincel_borra) +
		scroll_gui_get_from_in_mouse(scr_pincel_size)  +
		scroll_gui_get_from_in_mouse(scr_pincel_HUE)  +
		scroll_gui_get_from_in_mouse(scr_pincel_SATR)  +
		scroll_gui_get_from_in_mouse(scr_pincel_VALU)
	);