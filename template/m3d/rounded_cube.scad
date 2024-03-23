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

  // NOTE: minkowski() alone gives the mathematically right shape here!
  // however with actual cubes inside dimensions are far more accurate, as it
  // avoids strange artifacts (eg. height off by 0.02). this is especially
  // important for low values of $fn.
  union()
  {
    // OX
    translate([0, corner_r, corner_r])
      cube([size.x, is.y, is.z]);
    // OY
    translate([corner_r, 0, corner_r])
      cube([is.x, size.y, is.z]);
    // OZ
    translate([corner_r, corner_r, 0])
      cube([is.x, is.y, size.z]);
  }
}


module side_rounded_cube(size, corner_r)
{
  is = size - corner_r*[2,2,0]; // internal size
  assert( is[0] > 0 );
  assert( is[1] > 0 );
  assert( is[2] > 0 );

  hull()
    for(dx=[corner_r, size.x-corner_r])
      for(dy=[corner_r, size.y-corner_r])
        translate([dx, dy, 0])
          cylinder(r=corner_r, h=size.z);

  // NOTE: hull() alone gives the mathematically right shape here!
  // however with actual cubes inside dimensions are far more accurate, as it
  // avoids strange artifacts (eg. height off by 0.02). this is especially
  // important for low values of $fn.
  union()
  {
    // OX
    translate([0, corner_r, 0])
      cube([size.x, is.y, is.z]);
    // OY
    translate([corner_r, 0, 0])
      cube([is.x, size.y, is.z]);
  }
}


// example #1
if(false)
{
  $fn=100; // note the different when this value is set to eg. 20
  size=[40, 30, 20];
  rounded_cube(size, 5);
  %cube(size);
}

// example #2
if(false)
{
  $fn=100; // note the different when this value is set to eg. 20
  size=[40, 30, 20];
  side_rounded_cube(size, 5);
  %cube(size);
}
