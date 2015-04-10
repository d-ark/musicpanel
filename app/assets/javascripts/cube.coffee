@cubeColors = [0x006699, 0xFFFFFF, 0xA80000, 0xFF6600, 0xFFFF00, 0x33CC00]

width = window.innerWidth
height = window.innerHeight
cubeSize = (if width > height then height else width )/9

Cube = (color, x, y, z)->
  @geometry = new THREE.BoxGeometry( cubeSize, cubeSize, cubeSize );
  @material = new THREE.MeshBasicMaterial( { color: color, specular: 0x009900, shininess: 30, shading: THREE.FlatShading } )
  @cube = new THREE.Mesh( @geometry, @material );

  @afterRender = =>
    @cube.position.x += (x*1.1 - 0.5)*cubeSize
    @cube.position.y += (y*1.1 - 0.5)*cubeSize
    @cube.position.z += (z*1.1 - 0.5)*cubeSize

  @


$(document).on 'ready page:load', ->
  scene = new THREE.Scene();
  window.camera = new THREE.OrthographicCamera( -width/2 , width/2, -height/2, height/2, -1000, 1000 )

  window.renderer = new THREE.WebGLRenderer();
  renderer.setSize( window.innerWidth, window.innerHeight );
  document.body.appendChild( renderer.domElement );


  window.cubes = [
    new Cube(cubeColors[0], 0, 0, -1)
    new Cube(cubeColors[2], 1, 0, -1)
    new Cube(cubeColors[0], 1, 1, -1)
    new Cube(cubeColors[2], 0, 1, -1)
    new Cube(cubeColors[2], 0, -1, -1)
    new Cube(cubeColors[0], -1, 1, -1)
    new Cube(cubeColors[2], -1, 0, -1)
    new Cube(cubeColors[0], 1, -1, -1)
    new Cube(cubeColors[0], -1, -1, -1)


    new Cube(cubeColors[2], 0, 0, 0)
    new Cube(cubeColors[0], 1, 0, 0)
    new Cube(cubeColors[2], 1, 1, 0)
    new Cube(cubeColors[0], 0, 1, 0)
    new Cube(cubeColors[0], 0, -1, 0)
    new Cube(cubeColors[2], -1, 1, 0)
    new Cube(cubeColors[0], -1, 0, 0)
    new Cube(cubeColors[2], 1, -1, 0)
    new Cube(cubeColors[2], -1, -1, 0)


    new Cube(cubeColors[0], 0, 0, 1)
    new Cube(cubeColors[2], 1, 0, 1)
    new Cube(cubeColors[0], 1, 1, 1)
    new Cube(cubeColors[2], 0, 1, 1)
    new Cube(cubeColors[2], 0, -1, 1)
    new Cube(cubeColors[0], -1, 1, 1)
    new Cube(cubeColors[2], -1, 0, 1)
    new Cube(cubeColors[0], 1, -1, 1)
    new Cube(cubeColors[0], -1, -1, 1)
  ]

  for cube in cubes
    scene.add( cube.cube );
    do cube.afterRender

  camera.position.x = 0;
  camera.position.y = 0;
  camera.position.z = 10;

  render = ->
    requestAnimationFrame( render );

    camera.rotateX(0.01);
    camera.rotateY(0.01);

    renderer.render(scene, camera);

  render();
