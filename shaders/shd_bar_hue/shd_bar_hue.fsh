//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 color = vec4(vec3(v_vTexcoord.y), 1.);
    gl_FragColor = color;
}