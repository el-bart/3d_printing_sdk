use <outer_shell.scad>

// takes a module and provides its inner shell, of a 'wall' thickness.
module inner_shell(wall)
{
  intersection()
  {
    minkowski()
    {
      outer_shell(wall=wall)
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
    wall = 3;
    size = [20, 30, 10];
    inner_shell(wall=wall, $fn=10)
    {
      cube(size);
      sphere(r=4);
    }
    cut_size = size + 4*2*wall*[1,1,1];
    translate([-cut_size[0]+size[0]/2, -4*wall, -0*wall])
      cube(cut_size);
  }
