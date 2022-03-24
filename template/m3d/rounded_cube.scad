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

// example
if(false)
{
  $fn=100;
  size=[40, 30, 20];
  rounded_cube(size, 5);
  %cube(size);
}
