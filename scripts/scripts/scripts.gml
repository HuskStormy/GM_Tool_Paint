#macro BUTTON_CONTINUO	"continuo"
#macro BUTTON_SWITCH	"switch"
#macro BUTTON_PRESSED	"pressed"
#macro BUTTON_RELEASED	"released"

/// @function           button_gui_create(_name, _x, _y, _width, _height, _button_type, _value, _function, _mouse_gui);
/// @description        Crea un objeto de botón con propiedades específicas para su uso en la GUI.
/// @param {string}     _name          Nombre del botón.
/// @param {real}       _x             Posición X del botón.
/// @param {real}       _y             Posición Y del botón.
/// @param {real}       _width         Ancho del botón.
/// @param {real}       _height        Altura del botón.
/// @param {string}     _button_type   Tipo de botón (BUTTON_CONTINUO, BUTTON_SWITCH, BUTTON_PRESSED, BUTTON_RELEASED).
/// @param {bool}       _value         Estado inicial del botón (true/false).
/// @param {method}		_function      Función a ejecutar cuando el botón esté activo.
/// @param {bool}       _mouse_gui     Indica si el botón funciona en la capa GUI.
/// @return {object}                   Retorna una estructura que representa el botón.
/// @example {struct}
/// // Crear un botón que cambia entre activo y desactivo con cada clic:
/// var my_button = button_gui_create("MyButton", 100, 100, 200, 50, BUTTON_SWITCH, false, function() {
///     show_debug_message("Button was clicked!");
/// }, true);
function button_gui_create(_name = "", _x, _y, _width, _height, _button_type = BUTTON_SWITCH, _value = false, _function = function(){ show_debug_message("button_pressed") }, _mouse_gui = true) {
    return {
        name            : _name,           // Nombre del botón
        x               : _x,              // Posición X
        y               : _y,              // Posición Y
        width           : _width,          // Ancho del botón
        height          : _height,         // Altura del botón
        button_type     : _button_type,    // Tipo del botón
        my_function     : _function,       // Función asociada
        state_in_mouse  : false,           // Indica si el mouse está sobre el botón
        state_in_action : false,           // Indica si el botón está siendo presionado
        active          : _value,          // Estado inicial del botón
        mouse_gui       : _mouse_gui       // Indica si se usa GUI
    };
}

/// @function button_gui_step
/// @desc Actualiza el estado del botón según las interacciones del usuario.
/// @param {struct} _button_gui_id Objeto del botón que se va a actualizar.
function button_gui_step(_button_gui_id){
    var _b = _button_gui_id;
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

    // Ejecuta acciones según el tipo de botón
	if (_b.state_in_action){
		switch (_b.button_type) {
		    case BUTTON_CONTINUO:
		        _b.active = mouse_check_button(_button);  // Activo mientras el botón se mantenga presionado
		        break;
		    case BUTTON_SWITCH:
		        if (mouse_check_button_released(_button) and _b.state_in_mouse) 
				_b.active = !_b.active;  // Cambia de estado en cada clic
		        break;
		    case BUTTON_PRESSED:
		        _b.active = mouse_check_button_pressed(_button);  // Activo solo al presionar
		        break;
		    case BUTTON_RELEASED:
		        _b.active = mouse_check_button_released(_button);  // Activo solo al liberar
		        break;
		}
		if (_b.active) {
		    _b.my_function();  // Llama a la función solo si está activo
		}
	}
}

/// @function           button_gui_draw
/// @description        Dibuja un botón en pantalla con un cambio visual dependiendo de su estado (activo, mouse encima, clic presionado).
/// @param {struct}     _button_gui_id  Objeto del botón que se va a dibujar.
/// @return {void}
/// @example
/// // Dibujar un botón en su estado actual
/// button_gui_draw(my_button);
function button_gui_draw(_button_gui_id) {
    var b = _button_gui_id;

    var _color = c_white;  // Color predeterminado
    if (b.state_in_mouse) {
        if (mouse_check_button(mb_left)) _color = c_blue;  // Color cuando se presiona el botón
        else _color = c_gray;                              // Color cuando el mouse está encima
    } else {
        if (b.active) _color = c_black;                    // Color cuando está activo
        else _color = c_white;                             // Color predeterminado
    }

    draw_set_color(_color);
    draw_rectangle(b.x, b.y, b.x + b.width, b.y + b.height, false);  // Dibuja el fondo del botón
    draw_set_color(c_white);
    draw_rectangle(b.x, b.y, b.x + b.width, b.y + b.height, true);   // Dibuja el borde del botón
}

/// @function				button_gui_draw_sprite(button_gui_id, sprite, sprite_outline, img_free, img_select, img_press)
/// @description			Dibuja un botón utilizando un sprite para representar los diferentes estados del botón.
/// @param {Struct}			button_gui_id   Objeto del botón que se va a dibujar.
/// @param {Asset.GMSprite} sprite          Sprite utilizado para el botón.
/// @param {Asset.GMSprite} sprite_outline  (Opcional) Sprite utilizado para el borde del botón.
/// @param {real}			img_free        Índice de la imagen para el estado libre (sin interacción).
/// @param {real}			img_select      Índice de la imagen cuando el mouse está sobre el botón.
/// @param {real}			img_press       Índice de la imagen cuando el botón está siendo presionado.
/// @example
/// // Dibujar un botón con un sprite y diferentes estados
/// button_gui_draw_sprite(my_button, spr_button, spr_button_outline, 0, 1, 2);
function button_gui_draw_sprite(_button_gui_id, _sprite, _sprite_outline = pointer_null, _img_free = 0, _img_select = 1, _img_press = 2) {
    var b = _button_gui_id;

    var _i;
    if (b.state_in_mouse) {
        if (mouse_check_button(mb_left)) _i = _img_press;  // Imagen cuando el botón está presionado
        else _i = _img_select;                            // Imagen cuando el mouse está encima
    } else {
        if (b.active) _i = _img_press;                    // Imagen cuando está activo
        else _i = _img_free;                              // Imagen predeterminada
    }

    // Dibuja el sprite estirado para cubrir el área del botón
    draw_sprite_stretched(_sprite, _i, b.x, b.y, b.width, b.height);

    // Dibuja el borde si está definido
    if (_sprite_outline != pointer_null) {
        if (b.state_in_mouse) {
            draw_sprite_stretched(_sprite_outline, 0, b.x, b.y, b.width, b.height);
        }
    }
}

/// @function           button_gui_draw_debug
/// @description        Muestra información de depuración sobre el botón, incluyendo su nombre, estado y tipo.
/// @param {struct}     _button_gui_id  Objeto del botón que se va a depurar.
/// @return {void}
/// @example
/// // Mostrar información de depuración sobre un botón
/// button_gui_draw_debug(my_button);
function button_gui_draw_debug(_button_gui_id) {
    var b = _button_gui_id;

    // Lista de información para mostrar
    var list = [
        "name  : " + string(b.name),                      // Nombre del botón
        "value : " + string(b.active),                    // Estado actual
        "type  : " + string(b.button_type),               // Tipo de botón
        "active: " + (b.active ? "active" : "desactive")  // Activo o desactivo
    ];

    // Dibuja cada línea de información
    for (var i = 0; i < array_length(list); ++i) {
        draw_text(b.x, b.y + (12 * i) + b.height, list[i]);
    }
}



/// @function           button_gui_get_active
/// @description        Obtiene el estado activo del botón (true/false).
/// @param {object}     _button_gui_id  Objeto del botón.
/// @return {bool}      Retorna `true` si el botón está activo, `false` de lo contrario.
/// @example
/// var is_active = button_gui_get_active(my_button);
/// if (is_active) {
///     show_debug_message("El botón está activo");
/// }
function button_gui_get_active(_button_gui_id) {
    return (_button_gui_id.active);
}

/// @function           button_gui_get_name
/// @description        Obtiene el nombre del botón.
/// @param {object}     _button_gui_id  Objeto del botón.
/// @return {string}    Retorna el nombre del botón como texto.
/// @example
/// var button_name = button_gui_get_name(my_button);
/// show_debug_message("El nombre del botón es: " + button_name);
function button_gui_get_name(_button_gui_id) {
    return (_button_gui_id.name);
}

/// @function           button_gui_set_active
/// @description        Establece el estado activo del botón.
/// @param {object}     _button_gui_id  Objeto del botón.
/// @param {bool}       _bool           Nuevo estado del botón (`true` para activo, `false` para inactivo).
/// @return {void}
/// @example
/// // Activar un botón
/// button_gui_set_active(my_button, true);
function button_gui_set_active(_button_gui_id, _bool) {
    _button_gui_id.active = sign(abs(_bool));
}
/// @function           button_gui_set_name
/// @description        Establece un nuevo nombre para el botón.
/// @param {object}     _button_gui_id  Objeto del botón.
/// @param {string}     _name           Nuevo nombre para el botón.
/// @return {void}
/// @example
/// // Cambiar el nombre del botón
/// button_gui_set_name(my_button, "NuevoNombre");
function button_gui_set_name(_button_gui_id, _name) {
    _button_gui_id.name = string(_name);
}



function button_gui_get_from_in_mouse(_button_gui_id) {
    return sign(_button_gui_id.state_in_action + _button_gui_id.state_in_mouse);
}

/// @function           timer_create
/// @description        Crea un temporizador con propiedades personalizadas.
/// @param {real}       _time_max       Tiempo máximo del temporizador.
/// @param {real}       _step           Paso en el que el temporizador disminuye (mín. 1, máx. 100). Por defecto es 1.
/// @param {method}     _function    Función a ejecutar cuando el temporizador llegue a 0 (opcional).
/// @return {struct}    Retorna un objeto temporizador.
/// @example
/// // Crear un temporizador de 10 segundos con un paso de 1 y una función personalizada.
/// var my_timer = timer_create(10, 1, function() {
///     show_debug_message("El temporizador ha terminado.");
/// });
function timer_create(_time_max, _step = 1, _function = pointer_null) {
    return {
        time        : -1,
        time_max    : _time_max,
        time_step   : clamp(_step, 1, 100),
        my_function : _function
    };
}

/// @function           timer_step
/// @description        Actualiza el estado del temporizador. Si llega a 0, ejecuta la función asignada (si existe).
/// @param {object}     _timer_id       Objeto del temporizador.
/// @return {void}
/// @example
/// // En el evento Step del objeto, actualiza el temporizador.
/// timer_step(my_timer);
function timer_step(_timer_id) {
    var _t = _timer_id;

    if (_t.time == 0) {
        if (_t.my_function != pointer_null) {
            script_execute(_t.my_function);
        }
        _t.time = -1;  // Apaga el temporizador
    }

    if (_t.time > 0) {
        _t.time = clamp(_t.time - _t.time_step, 0, _t.time_max);
    }
}

/// @function           timer_set
/// @description        Configura el tiempo restante del temporizador.
/// @param {object}     _timer_id       Objeto del temporizador.
/// @param {real}       _time           Nuevo tiempo a establecer (por defecto, infinito).
/// @return {void}
/// @example
/// // Configurar un temporizador para que dure 5 segundos.
/// timer_set(my_timer, 5);
function timer_set(_timer_id, _time = 100000000) {
    var _t = _timer_id;
    _t.time = clamp(_time, 0, _t.time_max);
}


/// @function           timer_off
/// @description        Apaga el temporizador (lo desactiva).
/// @param {object}     _timer_id       Objeto del temporizador.
/// @return {void}
/// @example
/// // Apagar el temporizador.
/// timer_off(my_timer);
function timer_off(_timer_id) {
    var _t = _timer_id;
    _t.time = -1;
}


/// @function           timer_get_run
/// @description        Verifica si el temporizador está activo.
/// @param {object}     _timer_id       Objeto del temporizador.
/// @return {bool}      Retorna `true` si el temporizador está corriendo, `false` si está apagado.
/// @example
/// if (timer_get_run(my_timer)) {
///     show_debug_message("El temporizador está en ejecución.");
/// }
function timer_get_run(_timer_id) {
    var _t = _timer_id;
    return _t.time != -1;
}

/// @function           timer_get_time
/// @description        Obtiene el tiempo restante del temporizador.
/// @param {object}     _timer_id       Objeto del temporizador.
/// @return {real}      Tiempo restante del temporizador.
/// @example
/// var time_left = timer_get_time(my_timer);
/// show_debug_message("Tiempo restante: " + string(time_left));
function timer_get_time(_timer_id) {
    var _t = _timer_id;
    return _t.time;
}
