scr_bottonGUI_draw(bt_bar_lapiz);
scr_bottonGUI_draw(bt_bar_borrador);

scr_scrollGUI_draw(sl_bar_color,,,,1);
scr_scrollGUI_draw(sl_bar_satur,,,,2,scr_scrollGUI_get_value(sl_bar_color));
scr_scrollGUI_draw(sl_bar_value,,,,3,scr_scrollGUI_get_value(sl_bar_color));

scr_inputGUI_draw(TYPEGUI_COLOR, 
	[
		scr_scrollGUI_get_value(sl_bar_color), 
		scr_scrollGUI_get_value(sl_bar_satur), 
		scr_scrollGUI_get_value(sl_bar_value)
	],,128 + 32*21,12+24*1,24,24)
	
	
scr_scrollGUI_draw(sl_bar_size, true, TYPEGUI_TEXTO, 60);


var _x = 32;
var _y = 72;
var _w = room_width	-_x;
var _h = room_height-_y;

var _x1 = abs(_x - _w);
var _y1 = abs(_y - _h);
draw_rectangle(_x,_y,_w, _h, true)


//draw_circle(mouse_x-_x, mouse_y-_y, 4, true);
