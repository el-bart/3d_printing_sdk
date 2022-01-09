// return:
// x - for small values
// some fraction of x (>=16) - for larger values
function fn_preview_(x) = min( max(16, 0.2*x), x );
assert( fn_preview_(10) == 10 );
assert( fn_preview_(16) == 16 );
assert( fn_preview_(90)  > 16 );

// helper functions to define $fn=... to do less precise math
// in a preview mode. example usage:
//   sphere(r=50, $fn=fn(1000));
// would generate $fn=1000 when generating model, but $fn < 1000
// for preview mode. note that for small $fn's value is untouched.
function fn(x) = $preview ? fn_preview_(x) : x;
