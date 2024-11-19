#macro	RED		0
#macro	GREED	1
#macro	BLUE	2
#macro	ALPHA	3
#macro	COL		4


function my_get_color(_surf, _x, _y){
var _col = surface_getpixel_ext(_surf, _x, _y);
var _alpha	= (_col >> 24) & 255;
var _blue	= (_col >> 16) & 255;
var _green	= (_col >> 8) & 255;
var _red	= _col & 255;

return [_red, _green, _blue, _alpha, _col];
}