// takes a module, and provides its outer shell, of a 'wall' thickness
module outer_shell(wall)
{
  difference()
  {
    minkowski()
    {
      children();
      sphere(r=wall);
    }
    children();
  }
}

// example
if(false)
  intersection()
  {
    wall = 2;
    size = [20, 30, 10];
    outer_shell(wall=wall, $fn=20)
    {
      cube(size);
      sphere(r=4);
    }
    translate([-size[0]/2, -wall, -wall])
      cube(size + 2*wall*[1,1,1]);
  }
