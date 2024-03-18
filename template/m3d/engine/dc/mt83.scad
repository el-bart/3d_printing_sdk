// MT83 DC motor
// 12V
// 2.0A max
include<mt83_conf.scad>
include<../../math.scad>
use<../../fn.scad>


module engine_dc_mt83_mounts_slots(extra_len, extra_spacing=0)
{
  dr=37/2;
  size = 3;
  s = (size+extra_spacing)/size;
  for(r=[     0,  180,
          90-dr,  90+dr,
         -90-dr, -90+dr ])
    rotate([0, 0, r])
      translate([engine_dc_mt83_d/2-3*s, -3*s/2, -eps])
        scale([s, s, 1])
          cube([3+extra_len, 3, 3.5+eps]);
}


module engine_dc_mt83()
{
  module body()
  {
    // engine
    cylinder(r=engine_dc_mt83_d/2, h=engine_dc_mt83_len, $fn=fn(60));
    // top mount
    top_size=engine_dc_mt83_shaft_hold_h;
    translate([0, 0, engine_dc_mt83_len])
      cylinder(r=9.7/2, h=top_size, $fn=fn(25));
    // bottom mount
    bottom_size=3.4;
    translate([0, 0, -bottom_size])
      cylinder(r=7.5/2, h=bottom_size, $fn=fn(20));
    // main rotor
    translate([0, 0, engine_dc_mt83_len+top_size])
      cylinder(r=2/2, h=engine_dc_mt83_shaft_h, $fn=fn(10));
    // power pads
    pads_size=5.5;
    rotate([0, 0, 14])
      for(dx=[-1,+1])
        translate([dx*9, 0, -pads_size])
          cylinder(r=4.2/2, h=pads_size, $fn=fn(10));
  }

  difference()
  {
    body();
    engine_dc_mt83_mounts_slots(extra_len=1);
  }
}


engine_dc_mt83();
