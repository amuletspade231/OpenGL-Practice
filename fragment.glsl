varying vec4 position;
varying vec3 normal;
varying vec3 light_direction;

void main()
{
    vec4 n = normalize(vec4(normal, 0));
    vec4 l = vec4(light_direction, 1);
    vec4 l_norm = normalize(l);
    vec4 e_norm = normalize(-position);


    //vec4 ambient = gl_LightModel.ambient;
    vec4 ambient = vec4(0,0,0,0);
    vec4 diffuse = vec4(0, 0, 0, 0);
    vec4 specular = vec4(0, 0, 0, 0);

    for (int i = 0; i < gl_MaxLights; ++i) {
	vec4 reflection = float(2) * dot(normalize(l), n) * n - l;

	ambient += gl_FrontMaterial.ambient * gl_LightSource[i].ambient;
	diffuse += gl_LightSource[i].diffuse * gl_FrontMaterial.diffuse * max(dot(n, normalize(l)), float(0));
	specular += gl_LightSource[i].specular * gl_FrontMaterial.specular * pow(max(dot(e_norm, reflection), float(0)), gl_FrontMaterial.shininess);
    }

    gl_FragColor = ambient + diffuse + specular;
}
