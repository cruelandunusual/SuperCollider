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


/*
 * Mon 01-04-2024
 * strings, brackets, braces, etc
 *
 */
"Here's a string"
\greatSymbol
[1, 2, 3, 4, 5].scramble;
[1, 2, 3, 4, 5].reverse;
[1, 2, 3, 4, 5].mirror;

60.midicps.round(0.1);

exprand(1, 1000.0);
{exprand(1, 1000.0)};
rand(10);

/*
 *
 * if/else, case
 *
 */
if(rand(10) > 5, {"very true".postln}, {"very false".postln});

x = 10;
x == 10;

11.odd || 13.odd;

(
case
{10.odd}{"10".postln;}
{13.odd}{"13".postln;}
)

if(-2 < 0, {"neg num".postln}, {"pos num".postln});

(
~num = -2;
case
{~num == 0} {"WOW".postln}
{~num == 1} {"ONE!".postln}
{~num < 0} {"negative number!".postln}
{true} {"last case scenario".postln};
)

/*
 *
 * functions
 *
 */

f = {arg a, b; a*b};
f.value(3, 7);

~sillyRand = rrand(0, 10);
~sillyRand.value;
~sillyRand2 = {rrand(0, 10)};
~sillyRand2.value;

// Use this function to decide how to spend your Summer days
(
~whatToDo = {
var today, dayName, actions;
today = Date.getDate.dayOfWeek;
dayName =
case
{today==0} {"Sunday"}
{today==1} {"Monday"}
{today==2} {"Tuesday"}
{today==3} {"Wednesday"}
{today==4} {"Thursday"}
{today==5} {"Friday"}
{today==6} {"Saturday"};
actions = ["boomerang throwing", "arm wrestling", "stair climbing", "playing chess",
		"underwater hockey", "pea shooting", "a nap marathon"];
"Ah, " ++ dayName ++ "...! " ++ "What a good day for " ++ actions.choose;
};
)
// Run it in the morning
~whatToDo.value;


~squareNum = {arg r; r*r};

(
~areaOfCircle = {
	arg r;
	pi*~squareNum.value(r);
};
)
~radius = 4.5;
~areaOfCircle.value(~radius);

