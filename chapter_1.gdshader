shader_type canvas_item;

uniform float speed = 3.0;
uniform float intensity = 1.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float pulse = abs(sin(TIME * speed)) * intensity;

    vec4 white = vec4(1.0, 1.0, 1.0, tex.a);
    COLOR = mix(tex, white, pulse);
}