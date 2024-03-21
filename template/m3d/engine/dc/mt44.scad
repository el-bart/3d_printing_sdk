// MT44 DC motor
// 12V
// 0.6A max
include<mt44_conf.scad>
use<../../fn.scad>


module engine_dc_mt44_crosssection_2d()
{
  q = engine_dc_mt44_box_top;
  Q = engine_dc_mt44_box_size.x/2;
  h = engine_dc_mt44_box_size.y/2;
  B = [Q, 0];
  C = [Q-q, h];
  Dx = ( pow(C.x,2) + pow(C.y, 2) - pow(B.x, 2) - pow(B.y, 2) ) / ( 2*(C.x - B.x) );
  assert(Dx>0);
  R = Q + Dx;

  intersection()
  {
    translate([Dx, 0, 0])
      circle(r=R);
    translate([-Dx, 0, 0])
      circle(r=R);
    square([engine_dc_mt44_box_size.x, engine_dc_mt44_box_size.y], center=true);
  }
}


module engine_dc_mt44()
{
  module body()
  {
    linear_extrude(engine_dc_mt44_box_size.z)
      engine_dc_mt44_crosssection_2d($fn=fn(80));
  }

  module top()
  {
    cylinder(d=engine_dc_mt44_bearing_top_d, h=engine_dc_mt44_bearing_top_h, $fn=fn(30));
    translate([0, 0, engine_dc_mt44_bearing_top_h])
      cylinder(d=engine_dc_mt44_shaft_d, h=engine_dc_mt44_shaft_h, $fn=fn(20));
  }

  module bottom()
  {
    translate([0, 0, -engine_dc_mt44_bearing_bottom_h])
      cylinder(d=engine_dc_mt44_bearing_bottom_d, h=engine_dc_mt44_bearing_bottom_h, $fn=fn(30));
    for(dr=[0, 180])
      rotate(-[0, 0, engine_dc_mt44_lead_pos_angle + dr])
        translate([engine_dc_mt44_lead_pos_r, 0, -engine_dc_mt44_lead_h])
          cylinder(d=engine_dc_mt44_lead_d, h=engine_dc_mt44_lead_h, $fn=fn(20));
  }

  body();
  translate([0, 0, engine_dc_mt44_box_size.z])
    top();
  bottom();
}


engine_dc_mt44();
