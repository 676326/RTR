#version 430 core

layout (triangles) in;
layout (triangle_strip) out;
layout (max_vertices = 6) out;

// The time elapsed (by default there is no animation)
uniform float t;
uniform int iter = 1000; //number of iterations

uniform mat4 MVP;
uniform mat4 MV;
uniform mat4 M;
//Global iso level
uniform float isolevel = 0.05f;

in vec3 vertFragmentNormal[];
out vec3 fragmentNormal;

in vec3 lightDir[];
// out the blinn half vector
in vec3 halfVector[];
in vec3 eyeDirection[];
in vec3 vPosition[];

out vec3 lightDir0;
// out the blinn half vector
out vec3 halfVector0;
out vec3 eyeDirection0;
out vec3 vPosition0;


float h(vec3 q) // distance function
{
    float f=1.;
        // blobs
    f*=distance(q,vec3(-sin(t*.181)*.5,sin(t*.253),1.));
    f*=distance(q,vec3(-sin(t*.252)*.5,sin(t*.171),1.));
    f*=distance(q,vec3(-sin(t*.133)*.5,sin(t*.283),1.));
    f*=distance(q,vec3(-sin(t*.264)*.5,sin(t*.145),1.));
        // room
        f*=(cos(q.y))*(cos(q.z)+1.)*(cos(q.x+cos(q.z*3.))+1.)-.21+cos(q.z*6.+t/20.)*cos(q.x*5.)*cos(q.y*4.5)*.3;
    return f;
}



void emit(vec4 offset0, int i0) //avoids repeated code, emits vertex any time function is called
{
    vec4 vPosition = offset0 + gl_in[i0].gl_Position;
    gl_Position = MVP * (vPosition) - sin(t);
    EmitVertex();
}

//vec4 setvPos(0,0,0,0){
//    return 0;
//}


void main(void){
    int i;
        for (i=0; i<iter; i++){
        //pass through normals + directions ready for PhongFragment
        fragmentNormal = vertFragmentNormal[i];
        lightDir0 = lightDir[i];
        halfVector0 = halfVector[i];
        eyeDirection0 = eyeDirection[i];
        for (i=0; i<=2; i++){
            vec4 vPosition = gl_in[i].gl_Position;

            vec4 offset = vec4(-1.0, 1.0, 0.0, 0.0);
            emit(offset, i);

            offset = vec4(-1.0, -1.0, 0.0, 0.0);
            emit(offset, i);

            offset = vec4(1.0, 1.0, 0.0, 0.0);
            emit(offset, i);


            offset = vec4(1.0, -1.0, 0.0, 0.0);
            emit(offset, i);

            offset = vec4(-1.0, 1.0, 1.0, 0.0);
            emit(offset, i);

            offset = vec4(-1.0, -1.0, 1.0, 0.0);
            emit(offset, i);

            offset = vec4(1.0, 1.0, 1.0, 0.0);
            emit(offset, i);

            offset = vec4(1.0, -1.0, 1.0, 0.0);
            emit(offset, i);

            EndPrimitive();
        }


     }

}



