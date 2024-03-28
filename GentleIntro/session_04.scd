/*
 * Thu 28-03-2024
 * Objects, and a bit of looping too
 *
 */


2.squared;
(
var mynum = 2;
10.do({
	mynum.postln;
	mynum = mynum.squared;
	// mynum.postln;
});

)

(
f = { 3.yield };
x = Routine({ f.loop });
10.do({ x.next.postln })
)

(
f = {3.yield};
x = ({f.loop});
x.postln;
)