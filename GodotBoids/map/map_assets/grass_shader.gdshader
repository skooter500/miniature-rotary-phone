shader_type spatial;

uniform vec3 colour : source_color;
uniform vec3 colour2 : source_color;
uniform sampler2D noise;
uniform float noiseScale = 20.0;

varying vec3 worldPos;
render_mode cull_disabled;

void vertex() {
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec3 noiseLevel = texture(noise, worldPos.xz / noiseScale).rgb;
	ALBEDO = mix(colour, colour2, UV.y);
	
	if(!FRONT_FACING) {
		NORMAL = -NORMAL;
	}
}