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
	],,128 + 70*11.5,32*2,32,48)
	
	
scr_scrollGUI_draw(sl_bar_size, true, TYPEGUI_TEXTO, 60);