// threaded inserts from CNC Kitchen's store:
// https://cnckitchen.store
use <../fn.scad>

// M3 x 3.0
module ti_cnck_m3_short(dl=0)
{
  translate([0, 0, -4.0-dl])
    cylinder(d=4.0, h=4.0+dl, $fn=fn(50));
}

// M3 x 5.7
module ti_cnck_m3_standard(dl=0)
{
  translate([0, 0, -6.7-dl])
    cylinder(d=4.0, h=6.7+dl, $fn=fn(50));
}

// M3 x 5 x 4 (for Voron)
module ti_cnck_m3_voron(dl=0)
{
  translate([0, 0, -5.0-dl])
    cylinder(d=4.4, h=5.0+dl, $fn=fn(50));
}

// M5 x 5.8
module ti_cnck_m5_short(dl=0)
{
  translate([0, 0, -6.8-dl])
    cylinder(d=6.4, h=6.8+dl, $fn=fn(50));
}

// M5 x 9.5
module ti_cnck_m5_standard(dl=0)
{
  translate([0, 0, -10.5-dl])
    cylinder(d=6.4, h=10.5+dl, $fn=fn(50));
}



// M3 preview
translate([0, 0, 0])
{
  ti_cnck_m3_short();
  translate([1*8, 0, 0])
    ti_cnck_m3_standard();
  translate([2*8, 0, 0])
    ti_cnck_m3_voron();
}


// M5 preview
translate([0, 8, 0])
{
  ti_cnck_m5_short();
  translate([8, 0, 0])
    ti_cnck_m5_standard();
}
