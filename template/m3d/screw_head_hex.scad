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

// M3 screw head, with optional extra spacing
module screw_head_hex_m3(dy=0, dh=0)
{
  screw_head_hex(y=5.5+dy, h=2.5+dh);
}

// TODO: M3..M10

// M10 screw head, with optional extra spacing
module screw_head_hex_m10(dy=0, dh=0)
{
  screw_head_hex(y=17+dy, h=6.4+dh);
}


if(false)
{
  // screw-head model
  screw_head_hex_m3();
  translate([10, 0, 0])
  {
    // model with some extra spacing, to make a head slot
    screw_head_hex_m3(dy=0.5, dh=0.4);
  }
}
