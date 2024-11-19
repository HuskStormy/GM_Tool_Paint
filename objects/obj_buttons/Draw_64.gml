button_gui_draw(btt_pincel_lapiz, spr_ico_lapiz);
button_gui_draw(btt_pincel_borra, spr_ico_borrar);
button_gui_draw(btt_pincel_moveC, spr_ico_mano);
button_gui_draw(btt_pincel_cubet, spr_ico_cubeta);

scroll_gui_draw(scr_pincel_size);





var _scr_hue  = scr_pincel_HUE;
var _scr_satr = scr_pincel_SATR;
var _scr_value= scr_pincel_VALU;
	shader_set(shd_bar);
		shader_set_uniform_i(shader_get_uniform(shd_bar,"_var"), 1);
		shader_set_uniform_f(shader_get_uniform(shd_bar,"color_base"), abs(_scr_hue.val) );
		draw_sprite_stretched(spr_tex_ram, 0, _scr_hue.x, _scr_hue.y, _scr_hue.width, _scr_hue.height);
		
		shader_set_uniform_i(shader_get_uniform(shd_bar,"_var"), 2);
		shader_set_uniform_f(shader_get_uniform(shd_bar,"color_base"), abs(_scr_hue.val) );
		draw_sprite_stretched(spr_tex_ram, 0, _scr_satr.x, _scr_satr.y, _scr_satr.width, _scr_satr.height);

		shader_set_uniform_i(shader_get_uniform(shd_bar,"_var"), 3);
		shader_set_uniform_f(shader_get_uniform(shd_bar,"color_base"), abs(_scr_hue.val) );
		draw_sprite_stretched(spr_tex_ram, 0, _scr_value.x, _scr_value.y, _scr_value.width, _scr_value.height);
	shader_reset()


draw_set_color(c_white);
scroll_gui_draw(_scr_hue  );
scroll_gui_draw(_scr_satr );
scroll_gui_draw(_scr_value);

draw_set_color(make_color_hsv
				(
					scroll_gui_get_value(_scr_hue  )*255,
					scroll_gui_get_value(_scr_satr )*255,
					scroll_gui_get_value(_scr_value)*255,)
				)
draw_rectangle(8,8,60,60,false)

draw_set_color(c_white)
draw_rectangle(8,8,60,60,true)


//draw_text(0, 100, btt_gui_from_mouse)