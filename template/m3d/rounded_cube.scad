module rounded_cube(size, corner_r)
{
  is = size - corner_r*[2,2,2]; // internal size
  assert( is[0] > 0 );
  assert( is[1] > 0 );
  assert( is[2] > 0 );

  minkowski()
  {
    translate(corner_r*[1,1,1])
      cube(is);
    sphere(corner_r);
  }
}


module side_rounded_cube(size, corner_r)
{
  hull()
    for(dx=[corner_r, size.x-corner_r])
      for(dy=[corner_r, size.y-corner_r])
        translate([dx, dy, 0])
          cylinder(r=corner_r, h=size.z);
}


// example #1
if(false)
{
  $fn=100;
  size=[40, 30, 20];
  rounded_cube(size, 5);
  %cube(size);
}

// example #2
if(false)
{
  $fn=100;
  size=[40, 30, 20];
  side_rounded_cube(size, 5);
  %cube(size);
}
