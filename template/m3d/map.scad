// returns value for 'key' in dictionary 'dict' (list of lists).
function map_get(key, dict) = dict[ search([key], dict)[0] ][1];

assert( map_get("bar", dict = [
  ["foobar", "narf"],
  ["foo", 42],
  ["bar", [1,2,3]]
]) == [1,2,3] );

assert( map_get("foo", dict = [
  ["foobar", "narf"],
  ["foo", 42],
  ["bar", [1,2,3]]
]) == 42 );
