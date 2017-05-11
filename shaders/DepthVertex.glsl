#version 430 core

out float vDepth;

/// @brief the vertex passed in
layout (location = 0) in vec3 inVert;
/// @brief the normal passed in
layout (location = 2) in vec3 inNormal;
/// @brief the in uv
layout (location = 1) in vec2 inUV;
/// @brief flag to indicate if model has unit normals if not normalize
uniform bool Normalize;
// the eye position of the camera
uniform vec3 viewerPos;
/// @brief the current fragment normal for the vert being processed
out  vec3 vertFragmentNormal;uniform mat4 MV;


void main() {
    vec4 mvPosition = MV * vec4( inVert, 1.0 );
    vDepth = -mvPosition.z;
}

