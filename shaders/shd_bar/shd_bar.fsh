//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform int _var;
uniform float color_base;

// Función para convertir HSV a RGB
vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// Función que genera el gradiente de Hue
vec4 hueGradient(float x) {
    vec3 color = hsv2rgb(vec3(x, 1.0, 1.0));
    return vec4(color, 1.0);
}

// Función que genera el gradiente de Saturación
vec4 saturationGradient(float x) {
    vec3 color = hsv2rgb(vec3(color_base, x, 1.0));
    return vec4(color, 1.0);
}

// Función que genera el gradiente de Valor
vec4 valueGradient(float x) {
    vec3 color = hsv2rgb(vec3(color_base, 1.0, x));
    return vec4(color, 1.0);
}

void main()
{
    vec4 color;
    
    if (_var == 0) color = vec4(0.0, 0.0, 0.0, 0.2);
    else if (_var == 1) color = hueGradient(v_vTexcoord.y);
    else if (_var == 2) color = saturationGradient(v_vTexcoord.y);
    else if (_var == 3) color = valueGradient(v_vTexcoord.y);
	
	//color = vec4(v_vTexcoord.x, v_vTexcoord.x, v_vTexcoord.x, 1.);
    
    gl_FragColor = color;
}