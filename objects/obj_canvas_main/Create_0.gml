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
global.pincel = PINCEL_LAPIZ;
pincel = {
	type : PINCEL_NONE,
	size_max : 50,
	size : 0,
	alpha: 1,
	color: c_white
}