#version 330 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

uniform float uTime;
out vec3 color;

float offset = 0.1;
void main(){
    float movement = cos(uTime) + (offset + clamp(aPos.x, -0.05, 0.05));
    gl_Position = vec4(aPos.x + movement, aPos.y, aPos.z, 1.0);

    color = aColor;
}