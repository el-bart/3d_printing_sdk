use <fn.scad>

eps = 0.01;


module stepper_mount_holes_template(h=22.8)
{
  span = 31;
  for(ix=[-1, +1])
    for(iy=[-1, +1])
      translate(span/2*[ix, iy, 0] + [0, 0, h])
        children();
}

module stepper_shaft_slot(h, spacing)
{
  d = 5;
  cut = 0.5;
  linear_extrude(h)
    offset(delta=spacing)
      difference()
      {
        circle(d=d, $fn=fn(50));
        translate([-d/2, -3/2*d +cut])
          square([d, d]);
      }
}


module stepper_mock_nema17(h, rod_len)
{
  module body()
  {
    module shaft(l)
    {
      stepper_shaft_slot(h=l, spacing=0.5);
    }

    side = 42.5;
    translate(-0.5*[side, side, 0])
      cube([side, side, h]);
    // power connector
    {
      pc_size = [16.1, 5.4, 9.3];
      translate([-0.5*pc_size[0], -side/2-pc_size.y, 0])
        cube(pc_size);
    }
    // center berring cover
    cbh = 2;
    translate([0, 0, h])
      cylinder(d=22, h=cbh, $fn=fn(30));
    shaft(l = h + cbh + rod_len);
  }
  
  difference()
  {
    body();
    stepper_mount_holes_template()
      translate([0, 0, -5])
        cylinder(d=3, h=5+eps, $fn=fn(20));
  }
}


module stepper_mock_17hs4023()
{
  stepper_mock_nema17(h=22.8, rod_len=20);
}


//rotate([0, -90, 0])
  stepper_mock_17hs4023();
