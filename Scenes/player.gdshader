shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;
uniform vec4 albedo: source_color;
uniform sampler2D texture_albedo: source_color, filter_linear_mipmap, repeat_enable;
uniform float point_size: hint_range(0,120);
uniform float roughness: hint_range(0,1);
uniform sampler2D texture_metallic: hint_default_white, filter_linear_mipmap, repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness: hint_roughness_r, filter_linear_mipmap, repeat_enable;
uniform float specular;
uniform float matellic;
uniform sampler2D texture_normal: hint_roughness_normal, filter_linear_mipmap, repeat_enable;
uniform float normal_scale: hint_range(-16,16);
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform float fov = 47;
void vertex() {
	UV=UV+uv1_scale.xy+uv1_offset.xy;
	float scale = 1.0/tan(fov * 0.5 * PI/ 100.0);
	PROJECTION_MATRIX[0][0] = scale / (VIEWPORT_SIZE.x / VIEWPORT_SIZE.y);
	PROJECTION_MATRIX[1][1] = -scale;
	POSITION = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX.xyz, 1.0);
	POSITION.z = mix(POSITION.z,0,0.99);
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo, base_uv);
	albedo_tex *= COLOR;
	ALBEDO = albedo.rgb * albedo_tex.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
