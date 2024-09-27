// threaded inserts from CNC Kitchen's store:
// https://cnckitchen.store
use <../fn.scad>


// M2 x 3.0
module ti_cnck_m2(dl=0)
{
  translate([0, 0, -4.0-dl])
    cylinder(d=3.2, h=4.0+dl, $fn=fn(20));
}


// M3 x 3.0
module ti_cnck_m3_short(dl=0)
{
  translate([0, 0, -4.0-dl])
    cylinder(d=4.0, h=4.0+dl, $fn=fn(30));
}

// M3 x 5.7
module ti_cnck_m3_standard(dl=0)
{
  translate([0, 0, -6.7-dl])
    cylinder(d=4.0, h=6.7+dl, $fn=fn(30));
}

// M3 x 5 x 4 (for Voron)
module ti_cnck_m3_voron(dl=0)
{
  translate([0, 0, -5.0-dl])
    cylinder(d=4.4, h=5.0+dl, $fn=fn(30));
}


// M4 x 4.0
module ti_cnck_m4_short(dl=0)
{
  translate([0, 0, -5.0-dl])
    cylinder(d=5.6, h=5.0+dl, $fn=fn(40));
}

// M4 x 8.1
module ti_cnck_m4_standard(dl=0)
{
  translate([0, 0, -9.1-dl])
    cylinder(d=5.6, h=9.1+dl, $fn=fn(40));
}


// M5 x 5.8
module ti_cnck_m5_short(dl=0)
{
  translate([0, 0, -6.8-dl])
    cylinder(d=6.4, h=6.8+dl, $fn=fn(40));
}

// M5 x 9.5
module ti_cnck_m5_standard(dl=0)
{
  translate([0, 0, -10.5-dl])
    cylinder(d=6.4, h=10.5+dl, $fn=fn(40));
}


// M8 x 12.7
module ti_cnck_m8(dl=0)
{
  translate([0, 0, -13.7-dl])
    cylinder(d=9.7, h=13.7+dl, $fn=fn(40));
}


////////////////////////////////////////////////////////////////


// M2 preview
ti_cnck_m2();

// M3 preview
translate([0, 1*8, 0])
{
  ti_cnck_m3_short();
  translate([+8, 0, 0])
    ti_cnck_m3_standard();
  translate([-8, 0, 0])
    ti_cnck_m3_voron();
}

// M4 preview
translate([0, 2*8, 0])
{
  ti_cnck_m4_short();
  translate([8, 0, 0])
    ti_cnck_m4_standard();
}

// M5 preview
translate([0, 3*8, 0])
{
  ti_cnck_m5_short();
  translate([8, 0, 0])
    ti_cnck_m5_standard();
}

// M8 preview
translate([0, 4*8+2, 0])
  ti_cnck_m8();
