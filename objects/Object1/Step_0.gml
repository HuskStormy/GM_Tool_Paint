// En el Step Event

#region el canvas en blanco
	if (!surface_exists(_draw_surface)) {
	    _draw_surface = surface_create(surface_width, surface_height);
	    surface_set_target(_draw_surface);
	    draw_clear_alpha(c_white, 0.0);
	    surface_reset_target();
	}
#endregion

//// Control del lápiz (botón izquierdo)
//if (mouse_check_button_pressed(mb_left)) {
//    // Verificar si se hizo clic en el botón de guardar
//    if (point_in_rectangle(mouse_x, mouse_y, 
//        save_button_x, save_button_y, 
//        save_button_x + save_button_width, 
//        save_button_y + save_button_height)) {
        
//        // Generar nombre de archivo con fecha y hora
//        var datetime = string(current_year) + string(current_month) + string(current_day) + 
//                      "_" + string(current_hour) + string(current_minute) + string(current_second);
//        var filename = "dibujo_" + datetime + ".png";
        
//        // Obtener la ruta de documentos
        
//        var save_path = get_save_filename_ext(
//            "Imagen PNG|*.png|Imagen JPG|*.jpg", // Filtros de archivo
//            filename,                        // Nombre por defecto
//            environment_get_variable("USERPROFILE") + "\\Documents", // Carpeta inicial
//            "Guardar dibujo"                    // Título de la ventana
//        );
		
//		var full_path = save_path;

//		//var docs_path = working_directory;
//        // Guardar la surface
//        if (surface_exists(_draw_surface)) {
			
//            surface_save(_draw_surface,full_path);
//            show_message("Dibujo guardado en:\n" + full_path);
//        }
//    }
//}

brush_size = scr_scrollGUI_get_value(obj_bar.sl_bar_size)*60;
eraser_size = scr_scrollGUI_get_value(obj_bar.sl_bar_size)*60;



if (instance_exists(obj_bar)) brush_color = make_color_hsv(
	scr_scrollGUI_get_value(obj_bar.sl_bar_color)*255,
	scr_scrollGUI_get_value(obj_bar.sl_bar_satur)*255,
	scr_scrollGUI_get_value(obj_bar.sl_bar_value)*255);


if (variable_global_exists("pincel") and mouse_check_button(mb_left) and !scr_bottonGUI_get_fromMouse()){
	if (global.pincel == "lapiz"){
	    is_drawing = true;
	    is_erasing = false;
	}
	else if (global.pincel == "borrar"){
	    is_drawing = false;
	    is_erasing = true;
	}
}else{
    is_drawing = false;
    is_erasing = false;
}


show_debug_message(scr_bottonGUI_get_fromMouse())

// Dibujar o borrar
if (is_drawing || is_erasing) {
    if (surface_exists(_draw_surface)) {
        surface_set_target(_draw_surface);
        
        if (is_drawing)
			accion_drawing_pincel()
        else if (is_erasing)
			accion_drawing_borrador();
        
        surface_reset_target();
    }
}