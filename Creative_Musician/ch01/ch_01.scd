s.boot; // boot the server with the reserved variable s

s.plotTree; // plotTree shows server objects
s.quit; // um, quit

~result = 4.squared; // numbers are objects in SC
~longVarName = 4.reciprocal; // the tilde is required for var names longer than one letter
squared(~longVarName); // alternative function invocation syntax
squared(4);
/* the last thing computed is displayed in the post window, but postln will print whatever it's called to print */
~result.cubed-96.postln; // -> 96
~result.postln;


/* these two functions do the same thing */
345.neg();
neg(345);
/* a question of taste as to whether you call the method
on the object, or pass the object to the method as an argument */

/* however, the results of these operations are not equivalent */
2**3; // -> 8.0
2.cubed(); // -> 8
2.pow(3); // -> 8.0


// the most minimal audio example
{SinOsc.ar()}.play;

{SinOscFB.ar()}.play;

SinOsc.browse; // displays the class browser window for the respective object


Integer.browse; // opens the class browser window for this class
Float.browse;
Float.class;
Boolean.class;
4.browse; // doesn't work
4.class; // but this does -> Integer
"Text".class; // this also works -> String
4.0.class; // -> Float
SinOsc.class; // -> Meta_SinOsc




x = 3;
x.dup; // creates one more copy of the original and adds them to an array -> [ 3, 3 ]
x.dup(5); // creates the specified number of copies of the original -> [ 3, 3, 3, 3, 3 ]


/* order of operations */
1 + (4 + 2).pow(3); // brackets, then method calls, then symbolic operators

// need curly braces to make the operation inside the brackets a function that gets called each do cycle
10.do({"test".postln});

20.do({0.5.coin.postln}); // ditto

10.do({[1, 2, 3].choose.postln}); // ditto


10.rand; //generates a random number between 0 and 9

{SinOsc.ar(440).sum3rand}.plot; // .plot displays a graph of the audio wave

/* .coin emulates a toin coss, called on 0.3 it gives a 30% chance of returning true */
0.3.coin;

/* calling .coin on the output of a SinOsc produces output
that is either 1 or 0, with a greater probability of it being 1
when the oscillator output value is greater than 0.5 */
{SinOsc.ar(1110).coin}.plot;
{SinOsc.ar(1110)}.plot;

1 + 1.0; // -> 2.0
2.0.asBinaryArchive;
1 + 1.0.asBinaryArchive; // I don't know what this method does...
1.0.asBinaryArchive;

1.asBinaryArchive;
10.asBinaryDigits; // but this one is obvious...

345.asBinaryDigits;


35.isInteger; // -> true

(
var num;
num.isNil.postln; // -> true
num = 2;
num.isNil.postln; // -> false
)


(
~list = [2, 3, 4];

"element 0 of the array contains"+~list[0].class + "of value" + ~list[0].postln;
~list = ~list.add(5).squared;
~message = ("now the list contains"+~list).dup;
~message.postln;
"element 0 of the array contains"+~list[0].class + "of value" + ~list[0].postln;
~list.dup;
)


// Bitwise operations
5;
5&3; // bitwise AND -> 1


/*
------------------------------------------------------------------

Functions

------------------------------------------------------------------
*/

// Defining and evaluating a function with an argument
(
f = {
	arg input = 4; // set default value for input if no value given when calling
	var num;
	num = input.squared;
	num.postln;
	num = num.reciprocal;
	num.postln;
};
)
f.();
//////////////////////////////////////////////////////////

/* Defining and evaluating a function with multiple arguments
   declared unsing the "pipe" syntax */
(
g = { |input1 = 2, input2 = 6|
	var num;
	input1.squared.postln;
	input2.reciprocal.postln;
};
)

g.value;
g.(5, 10);
//////////////////////////////////////////////////////////
/* a minimal function definition, stored in variable 'x' */
(
x = {
	var a;
	a = FSinOsc.ar(880);
	//[a.neg, a.reciprocal ]
}
)

y = x.play; // play x and store the resulting synth in y

y.free; // free the synth stored in y


// 1.7 - Randomness




