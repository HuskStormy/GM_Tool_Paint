var _x = 96;
var _y = 0;
var _size = 48;
var _offset = _size + 4; 

btt_pincel_lapiz	= button_gui_create("pincel", _x + _offset*00,_y,_size,_size,BUTTON_PRESSED,0,function(){obj_canvas_main.pincel.type = PINCEL_LAPIZ});
btt_pincel_borra	= button_gui_create("borrar", _x + _offset*01,_y,_size,_size,BUTTON_PRESSED,0,function(){obj_canvas_main.pincel.type = PINCEL_BORRA});
btt_pincel_moveC	= button_gui_create("Mano"  , _x + _offset*02,_y,_size,_size,BUTTON_PRESSED,0,function(){obj_canvas_main.pincel.type = PINCEL_MANO});
btt_pincel_cubet	= button_gui_create("cubeta", _x + _offset*03,_y,_size,_size,BUTTON_PRESSED,0,function(){obj_canvas_main.pincel.type = PINCEL_CUBETA});
scr_pincel_size		= scroll_gui_create("size"  , _x + _offset*04,_y,_size*5,_size,,0.5);


var _scr_x = 0;
var _scr_y = 0;
var _scr_w = 48
var _bordo = 64;
var _y1 = _bordo;
var _y2 = display_get_gui_height() - _bordo;
var _scr_h = _y2 - _y1;

scr_pincel_HUE		= scroll_gui_create("size", _scr_x+_scr_w*00,_y1+(_scr_h/2)*00, _scr_w,_scr_h,SCROLL_VERTICAL,0.5);
scr_pincel_SATR		= scroll_gui_create("size", _scr_x+_scr_w*01,_y1+(_scr_h/2)*00, _scr_w,_scr_h/2,SCROLL_VERTICAL,0.5);
scr_pincel_VALU		= scroll_gui_create("size", _scr_x+_scr_w*01,_y1+(_scr_h/2)*01, _scr_w,_scr_h/2,SCROLL_VERTICAL,0.5);



//scr_pincel_size		= scroll_gui_create("size", _x,_y + _scr_h*4,_scr_h,_scr_w,SCROLL_HORIZONTAL,0.5);



btt_gui_from_mouse = false;