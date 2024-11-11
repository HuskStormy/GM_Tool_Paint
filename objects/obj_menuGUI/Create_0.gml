var _r = 70;
var _w = 64;
var _x = 128;
var _y = (_r/2);

bt_bar_lapiz	= scr_bottonGUI_create("lapiz" , _x + _r*0,_y,_w,_w,spr_icon_lapiz		,function(){global.pincel = "lapiz"});
bt_bar_borrador	= scr_bottonGUI_create("borrar", _x + _r*1,_y,_w,_w,spr_icon_borrador	,function(){global.pincel = "borrar"});


sl_bar_size = scr_scrollGUI_create("tamaño",_x + _r*4,16+32*0);

sl_bar_color = scr_scrollGUI_create("HUE",_x + _r*9,16+32*0,0,,24);
sl_bar_satur = scr_scrollGUI_create("SATURACION",_x + _r*9,16+32*1,0,,24);
sl_bar_value = scr_scrollGUI_create("VALOR",_x + _r*9,16+32*2,1,,24);