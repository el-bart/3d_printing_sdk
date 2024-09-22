// threaded inserts from CNC Kitchen's store:
// https://cnckitchen.store
use <../fn.scad>

// M3 x 3.0
module ti_cnck_m3_short()
{
  translate([0, 0, -4])
    cylinder(d=3.9, h=4, $fn=fn(50));
}

// M3 x 5.7
module ti_cnck_m3_long()
{
  translate([0, 0, -6.7])
    cylinder(d=3.9, h=6.7, $fn=fn(50));
}

// M5 x 5.8
module ti_cnck_m5_short()
{
  translate([0, 0, -6.8])
    cylinder(d=6.3, h=6.8, $fn=fn(50));
}

// M5 x 9.5
module ti_cnck_m5_long()
{
  translate([0, 0, -10.5])
    cylinder(d=6.3, h=10.5, $fn=fn(50));
}



// M3 preview
translate([0, 0, 0])
{
  ti_cnck_m3_short();
  translate([8, 0, 0])
    ti_cnck_m3_long();
}


// M5 preview
translate([0, 8, 0])
{
  ti_cnck_m5_short();
  translate([8, 0, 0])
    ti_cnck_m5_long();
}
