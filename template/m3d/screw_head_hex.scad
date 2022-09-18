// generic hex-sided screw head.
//   y - distance between parallel edges (often denotated as 'd' in specs)
//   h - height of the head
module screw_head_hex(y, h)
{
  a = 120;
  x = y/2 * 1/sin(a/2);
  for(r=[0, 120, 240])
    rotate([0, 0, r])
      translate(-1/2*[x, y, 0])
        cube([x, y, h]);
}

//
// M2-M12 sizes, based on ISO 4032 norm
//

// M2 screw head, with optional extra spacing
module screw_head_hex_m2(dy=0, dh=0)
{
  screw_head_hex(y=4+dy, h=1.35+dh);
}

// M3 screw head, with optional extra spacing
module screw_head_hex_m3(dy=0, dh=0)
{
  screw_head_hex(y=5.5+dy, h=2.5+dh);
}

// M4 screw head, with optional extra spacing
module screw_head_hex_m4(dy=0, dh=0)
{
  screw_head_hex(y=7+dy, h=2.9+dh);
}

// M5 screw head, with optional extra spacing
module screw_head_hex_m5(dy=0, dh=0)
{
  screw_head_hex(y=8+dy, h=4.4+dh);
}

// M6 screw head, with optional extra spacing
module screw_head_hex_m6(dy=0, dh=0)
{
  screw_head_hex(y=10+dy, h=4.9+dh);
}

// M8 screw head, with optional extra spacing
module screw_head_hex_m8(dy=0, dh=0)
{
  screw_head_hex(y=13+dy, h=6.44+dh);
}

// M10 screw head, with optional extra spacing
module screw_head_hex_m10(dy=0, dh=0)
{
  screw_head_hex(y=16+dy, h=8.04+dh);
}

// M12 screw head, with optional extra spacing
module screw_head_hex_m12(dy=0, dh=0)
{
  screw_head_hex(y=18+dy, h=10.37+dh);
}

// M10 screw head, with optional extra spacing
module screw_head_hex_m10(dy=0, dh=0)
{
  screw_head_hex(y=17+dy, h=6.4+dh);
}


if(false)
{
  translate([0, 0,0])  screw_head_hex_m2();
  translate([0, 6,0])  screw_head_hex_m3();
  translate([0,14,0])  screw_head_hex_m4();
  translate([0,23,0])  screw_head_hex_m5();
  translate([0,34,0])  screw_head_hex_m6();
  translate([0,47,0])  screw_head_hex_m8();
  translate([0,65,0])  screw_head_hex_m10();
  translate([0,85,0])  screw_head_hex_m12();

  translate([6, 0, 0])
  {
    // model with some extra spacing, to make a head slot
    screw_head_hex_m2(dy=0.5, dh=0.4);
  }
}
