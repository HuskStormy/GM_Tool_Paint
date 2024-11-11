	var _x = 32;
	var _y = 72;
	var _w = room_width	-_x;
	var _h = room_height-_y;

// En el Draw Event
if (surface_exists(_draw_surface)) {
    draw_surface(_draw_surface, 0+_x, 0+_y);
    
    // Dibujar el cursor del borrador cuando está activo
    if (is_erasing) {
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_circle(mouse_x, mouse_y, eraser_size/2, true);
        draw_set_alpha(1);
    }
    
    // Dibujar botón de guardado
    draw_set_color(c_blue);
    draw_rectangle(save_button_x, save_button_y, 
                  save_button_x + save_button_width, 
                  save_button_y + save_button_height, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(save_button_x + save_button_width/2, 
              save_button_y + save_button_height/2, 
              "Guardar");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

