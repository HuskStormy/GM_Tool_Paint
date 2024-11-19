#macro SCROLL_VERTICAL		"vertical"
#macro SCROLL_HORIZONTAL	"horizontal"

function scroll_gui_create(_name = "", _x, _y, _width, _height, _scroll_type = SCROLL_HORIZONTAL, _val = 0, _mouse_gui = true){
	_val = clamp(_val, 0, 1);
	
	return {
		name	: _name,
		x		: _x,
		y		: _y,
		width	: _width,
		height	: _height,
		type	: _scroll_type,
        x1		: _x + (_width*_val),
		y1		: _y + (_height*_val),
		val		: _val,
        state_in_mouse  : false,           // Indica si el mouse está sobre el botón
        state_in_action : false,           // Indica si el botón está siendo presionado
        mouse_gui       : _mouse_gui       // Indica si se usa GUI
	}
}

function scroll_gui_step(_scroll_gui_id){
    var _b = _scroll_gui_id;
    var _mx, _my;
	
    // Determina la posición del mouse en la capa GUI o en la room
    _mx = _b.mouse_gui ? device_mouse_x_to_gui(0) : mouse_x;
    _my = _b.mouse_gui ? device_mouse_y_to_gui(0) : mouse_y;
    
    // Verifica si el mouse está sobre el botón
    var _point = point_in_rectangle(_mx, _my, _b.x, _b.y, _b.x + _b.width, _b.y + _b.height);
    var _button = mb_left;

    _b.state_in_mouse = _point;
    
    // Manejamos el estado de acción del botón
    if (_b.state_in_mouse && mouse_check_button_pressed(_button)) {
        _b.state_in_action = true;
    }
    if (!mouse_check_button(_button)) {  // Asegura que el estado se libere cuando el botón no está presionado
        _b.state_in_action = false;
    }
	
	if (_b.state_in_action){
		if (_b.type == SCROLL_HORIZONTAL){
	        var _mouse_val = clamp(_mx, _b.x, _b.x + _b.width);
			_b.val= (_mouse_val - _b.x) / _b.width;
	        
			
		}else 	if (_b.type == SCROLL_VERTICAL){
	        var _mouse_val = clamp(_my, _b.y, _b.y + _b.height);
			_b.val= (_mouse_val - _b.y) / _b.height;
		}
	}
	if (_b.type == SCROLL_HORIZONTAL)	_b.x1 = _b.x + _b.width*_b.val;
	if (_b.type == SCROLL_VERTICAL)		_b.y1 = _b.y + _b.height*_b.val;
}

function scroll_gui_set_position( _scroll_gui_id, _x, _y, _width, _height){
	var _b = _scroll_gui_id;
	_b.x = _x;
	_b.y = _y;
	_b.width = _width;
	_b.height= _height;
}

function scroll_gui_draw(_scroll_gui_id){
    var _b = _scroll_gui_id;
	
	
	draw_rectangle(_b.x, _b.y, _b.x + _b.width, _b.y + _b.height, true);
	
	if (_b.type == SCROLL_HORIZONTAL){
		draw_circle(_b.x1, _b.y + (_b.height/2),(_b.height/4),false);
		draw_roundrect(_b.x1-2, _b.y, _b.x1+2, _b.y + _b.height, false)
	}
	if (_b.type == SCROLL_VERTICAL){
		draw_circle(_b.x + (_b.width/2), _b.y1, (_b.width/4),false);
		draw_roundrect(_b.x, _b.y1 - 2, _b.x + _b.width, _b.y1 + 2, false)
	}
	//draw_text(_b.x, _b.y+64, _b.val);
}

function scroll_gui_get_from_in_mouse(_scroll_gui_id) {
    return sign(_scroll_gui_id.state_in_action + _scroll_gui_id.state_in_mouse);
}
function scroll_gui_get_value(_scroll_gui_id) {
    return (_scroll_gui_id.val);
}