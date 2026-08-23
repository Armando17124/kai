shader_type fog;

uniform float density : hint_range(0.0, 1.0) = 0.1;
uniform vec3 albedo : source_color = vec3(0.8, 0.8, 0.85);
uniform sampler3D noise_tex : repeat_enable, filter_linear;
uniform float scroll_speed = 0.015;
uniform float noise_scale = 3.0;
uniform float contrast = 2.5;

void fog() {
    vec3 base_uvw = UVW * noise_scale;

    // Capa 1: lenta, en diagonal
    vec3 uvw1 = base_uvw;
    uvw1.x = fract(uvw1.x + TIME * scroll_speed * 0.4);
    uvw1.z = fract(uvw1.z + TIME * scroll_speed * 0.6);
    float n1 = texture(noise_tex, uvw1).r;

    // Capa 2: un poco más rápida, otra escala, otra dirección
    vec3 uvw2 = base_uvw * 1.7 + vec3(5.0, 2.0, 8.0);
    uvw2.x = fract(uvw2.x - TIME * scroll_speed * 0.9);
    uvw2.y = fract(uvw2.y + TIME * scroll_speed * 0.3);
    float n2 = texture(noise_tex, uvw2).r;

    float n = mix(n1, n2, 0.5);

    // Aumenta el contraste: empuja los valores bajos hacia 0 y los altos hacia 1
    n = clamp((n - 0.5) * contrast + 0.5, 0.0, 1.0);

    DENSITY = density * n;
    ALBEDO = albedo;
}