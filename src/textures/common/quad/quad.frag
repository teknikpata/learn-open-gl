#version 330 core
out vec4 fragColor;

in vec3 vColor;
in vec2 vTexCoord;

uniform sampler2D uTexture1;
uniform sampler2D uTexture2;

void main() {
    fragColor = mix(texture(uTexture1, vTexCoord), texture(uTexture2, vTexCoord), 0.8);
}