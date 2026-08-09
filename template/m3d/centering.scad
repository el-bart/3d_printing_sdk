module center(axis, size)
{
  c = [ axis.x?1:0, axis.y?1:0, axis.z?1:0 ];
  translate([ c.x*-size.x/2, c.y*-size.y/2, c.z*-size.z/2 ])
    children();
}


module center_xy(size)
{
  center([1,1,0], size)
    children();
}


s = [30,20,10];
if(1)
  center([0,1,0], s)
    cube(s);
if(0)
  center_xy(s)
    cube(s);
