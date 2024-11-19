surf_width	= 640;
surf_height = 640;
surf_x = (room_width/2 ) - (surf_width/ 2);
surf_y = (room_height/2) - (surf_height/2);

surf_canvas = -1;

mouse = {
	x : mouse_x, y: mouse_y,
	prex : mouse_x, prey : mouse_y,
	press : false
	}




#macro PINCEL_NONE	0
#macro PINCEL_LAPIZ 1
#macro PINCEL_BORRA 2
#macro PINCEL_MANO	3
#macro PINCEL_CUBETA 4

global.pincel = PINCEL_LAPIZ;
pincel = {
	type : PINCEL_NONE,
	size_max : 50,
	size : 0,
	alpha: 1,
	color: c_white
}

tolerance = 32; // Ajustable según necesites


// Añade esta función de ayuda para comparar colores
function colors_are_similar(color1, color2, tolerance) {
    var r1 = color_get_red(color1);
    var g1 = color_get_green(color1);
    var b1 = color_get_blue(color1);
    
    var r2 = color_get_red(color2);
    var g2 = color_get_green(color2);
    var b2 = color_get_blue(color2);
    
    return (abs(r1 - r2) <= tolerance &&
            abs(g1 - g2) <= tolerance &&
            abs(b1 - b2) <= tolerance);
}
