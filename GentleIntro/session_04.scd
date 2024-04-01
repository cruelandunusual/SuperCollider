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

/*
 * Fri 29-03-2024
 * Objects, receiver notation, functional notation
 *
 */
5.dup(20);
dup(5, 20);

pi.round();
round(pi, 0.1);

dup(round(rand(100.00), 0.01), 4);
exprand(1, 500);

"Here's a string"
\greatSymbol
[1, 2, 3, 4, 5].scramble;
[1, 2, 3, 4, 5].reverse;
[1, 2, 3, 4, 5].mirror;

60.midicps.round(0.1);

exprand(1, 1000.0);
{exprand(1, 1000.0)};
rand(10);
if(rand(10) > 5, {"very true".postln}, {"very false".postln});
