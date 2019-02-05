varying vec4 position;
varying vec3 normal;
varying vec3 light_direction;

void main()
{
    vec4 n = normalize(vec4(normal, 0));
    //vec4 l = vec4(light_direction, 0);
    vec4 l = (gl_LightSource[0].position - position);
    vec4 l_norm = normalize(l);
    vec4 e_norm = normalize(position - vec4(0, 0, 0, 0));


    vec4 ambient = gl_LightModel.ambient * gl_FrontMaterial.ambient * gl_LightSource[0].ambient;
    //vec4(1, 0, 0, 1);

    vec4 diffuse = gl_LightSource[0].diffuse * gl_FrontMaterial.diffuse * max(dot(n, l_norm), float(0));
    //vec4 diffuse = vec4(0, 0, 0, 0);
    //vec4(0, 1, 0, 1);

    vec4 reflection = float(2) * dot(l_norm, n)*n - l_norm;
    vec4 specular = gl_LightSource[0].specular * gl_FrontMaterial.specular * pow(max(dot(e_norm, normalize(reflection)), float(0)), gl_FrontMaterial.shininess);
    //vec4 specular = vec4(0, 0, 0, 0);
    //vec4(0, 0, 1, 1);

//    for (int i = 0; i < gl_MaxLights; ++i) {
//	vec4 l_curr = gl_LightSource[i].position - position;
//	vec4 reflection = float(2) * dot(l_norm, n) * n - l;
//
//	ambient *= gl_LightSource[i].ambient;
//	diffuse += gl_LightSource[i].diffuse * gl_FrontMaterial.diffuse * max(dot(n, normalize(l_curr)), float(0));
//	specular += gl_LightSource[i].specular * gl_FrontMaterial.specular * pow(max(dot(e_norm, normalize(reflection)), float(0)), gl_FrontMaterial.shininess);
//    }

    gl_FragColor = ambient + diffuse + specular;
}
