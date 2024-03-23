module rounded_cube(size, corner_r)
{
  is = size - corner_r*[2,2,2]; // internal size
  assert( is[0] > 0 );
  assert( is[1] > 0 );
  assert( is[2] > 0 );

  // NOTE: while minkowski() could be used here, with actual cube inside
  // dimensions are more accurate, avoid strange artifacts. this is especially
  // important for low values of $fn.

  // center crosses for side wall
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
  // roundings around the edges
  translate(corner_r*[1,1,1])
  {
    // corners
    for(dx=[0, is.x])
      for(dy=[0, is.y])
        for(dz=[0, is.z])
          translate([dx, dy, dz])
            sphere(corner_r);
    // OX edges
    for(dy=[0, is.y])
      for(dz=[0, is.z])
        translate([0, dy, dz])
          rotate([0, 90, 0])
            cylinder(r=corner_r, h=is.x);
    // OY edges
    for(dx=[0, is.x])
      for(dz=[0, is.z])
        translate([dx, 0, dz])
          rotate([-90, 0, 0])
            cylinder(r=corner_r, h=is.y);
    // OZ edges
    for(dx=[0, is.x])
      for(dy=[0, is.y])
        translate([dx, dy, 0])
          rotate([0, 0, 0])
            cylinder(r=corner_r, h=is.z);
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
if(true)
{
  $fn=30;
  size=[40, 30, 20];
  rounded_cube(size, 5);
//  %cube(size);
}

// example #2
if(false)
{
  $fn=30;
  size=[40, 30, 20];
  side_rounded_cube(size, 5);
  %cube(size);
}
