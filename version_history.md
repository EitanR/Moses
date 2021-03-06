#Version history#

##1.3.0 (11/12/12)
* Removed _.iterate (slower than pairs, ipairs)
* Added _.identity
* Removed _.curry (was more like a closure, will provide a proper implementation later)
* Removed _.iter_to_array
* Most of all functions rewritten
* _.import/_.mixin now imports library functions to the global env.
* Added type checking functions as object functions
* Added new functions and aliases : Moses has 85 unique functions, 117 counting aliases.
* Added HTML docs
* Added Specs
* Added samples

##1.2.1 (08/20/12)
* Added <tt>_.takeWhile</tt> (as alias to <tt>_.selectWhile</tt>)
* Added <tt>_.dropWhile</tt> and <tt>_.rejectWhile</tt> (as alias)
* Updated Moses_Lib_Test.lua
* Updated documentation

##1.2 (08/19/12)
* Added <tt>_.selectWhile</tt>
* Added <tt>_.mapReduce</tt> and <tt>_.mapr</tt> (as alias)
* Added <tt>_.mapReduceRight</tt> and <tt>_.maprr</tt> (as alias)
* Added <tt>_.bindn</tt>
* Added <tt>_.appendLists</tt>
* Updated Moses_Lib_Test.lua
* Updated documentation

##1.1 (08/04/12)
* Removed <tt>_.contains</tt> as alias to <tt>_.include</tt>
* Added <tt>_.removeRange</tt> (as Array function)
* Added <tt>_.sameKeys</tt> and <tt>_.contains</tt> (as Collection functions)
* Added <tt>_.bind</tt> (as Utility function)
* Updated Moses_Lib_Test.lua
* Updated documentation

##1.0 (08/02/12)
* Added <tt>_.append</tt>, <tt>_.invert</tt>, <tt>_.import</tt>, <tt>_.template</tt>, <tt>_.curry</tt>
* Updated Moses_Lib_Test.lua
* Updated documentation

##0.1 (07/24/12)
* Initial Release
