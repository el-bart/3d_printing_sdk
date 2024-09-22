use <../../fn.scad>

eps = 0.01;


module nema17_stepper_mount_holes_template(h)
{
  span = 31;
  for(ix=[-1, +1])
    for(iy=[-1, +1])
      translate(span/2*[ix, iy, 0] + [0, 0, h])
        children();
}


module nema17_stepper_shaft_slot(h, spacing)
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


module nema17_stepper_mock(h, rod_len, mounts_at_zero=false)
{
  module body()
  {
    side = 42.5;
    translate(-0.5*[side, side, 0])
      cube([side, side, h]);
    // power connector
    {
      pc_size = [16.5, 5.4, 9.4];
      translate([-0.5*pc_size[0], -side/2-pc_size.y, 0])
        cube(pc_size);
    }
    // center berring cover
    cbh = 2;
    translate([0, 0, h])
      cylinder(d=22, h=cbh, $fn=fn(30));
    nema17_stepper_shaft_slot(h = h + cbh + rod_len, spacing=0);
  }

  translate([0, 0, (mounts_at_zero?-1:0)*h])
  difference()
  {
    body();
    nema17_stepper_mount_holes_template(h=h)
      translate([0, 0, -5])
        cylinder(d=3, h=5+eps, $fn=fn(20));
  }
}

// 12[V]
// 0.7[A]
// 0.16[Nm]
// 200[tpr]
module nema17_stepper_mock_17hs4023(mounts_at_zero=false)
{
  nema17_stepper_mock(h=22.8, rod_len=20, mounts_at_zero=mounts_at_zero);
}

// 12[V]
// 1.5[A]
// 0.42[Nm]
// 200[tpr]
module nema17_stepper_mock_17hs4401(mounts_at_zero=false)
{
  nema17_stepper_mock(h=37.3, rod_len=21.75, mounts_at_zero=mounts_at_zero);
}


//rotate([0, -90, 0])
nema17_stepper_mock_17hs4023(mounts_at_zero=true);

translate([50, 0, 0])
  nema17_stepper_mock_17hs4401(mounts_at_zero=true);
