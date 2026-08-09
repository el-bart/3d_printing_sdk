module equilateral_triangle(x, h, centered=false)
{
  r = x / 2 / cos(180/3/2);
  b = 360/3;
  c = centered ? 0 : 1;

  translate(c*[x/2, x*sin(180/3) - r, 0])
    linear_extrude(h)
    polygon([ [        0, r       ],
              [+r*sin(b), r*cos(b)],
              [-r*sin(b), r*cos(b)],
            ]);
}


translate([-20, 0, 0])
  equilateral_triangle(10, 3);

equilateral_triangle(10, 3, centered=true);
