s.boot; // boot the server with the reserved variable s

s.plotTree; // plotTree shows server objects
s.quit; // um, quit

~result = 4.squared; // numbers are objects in SC
~longVarName = 4.reciprocal;
squared(~longVarName); // alternative function invocation syntax
squared(4);
/* the last thing computed is displayed in the post window, but postln will print whatever it's called to print */
~result.cubed-96.postln;
~result.postln;

// the most minimal audio example
{SinOsc.ar()}.play;

{SinOscFB.ar()}.play;

SinOsc.browse; // displays the class browser window for the respective object

4.browse; // doesn't work

4.class; // but this does -> Integer
"Text".class; // this also works -> String
4.0.class; // -> Float

4.0 * 3.0; // -> 12.0

SinOsc.class; // -> Meta_SinOsc



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



10.rand; //generates a random number between 0 and 9

{SinOsc.ar(440).sum3rand}.plot; // .plot displays a graph of the audio wave

/* .coin emulates a toin coss, called on 0.3 it gives a 30% chance of returning true */
0.3.coin;

{SinOsc.ar(110).coin}.plot;

1 + 1.0.asBinaryArchive;
1.0.asBinaryArchive;

1.asBinaryArchive;
1.asBinaryDigits;

345.asBinaryDigits;

Integer.browse;
Float.browse;
Float.class;

345.neg();
neg(345);

2**3;
2.cubed();

3.round(2);

2.pow(3);

Boolean.class;

0.3.coin;

x = 3;
y = 4;
x;
y = x.dup(3);
x;
y;

1 + (4 + 2).pow(3);
10.do({"test".postln});

20.do({0.5.coin.postln});

10.do({[1, 2, 3].choose.postln});

//if(x == y)


35.isInteger;

(

var num;
num.isNil.postln;
num = 2;
num.isNil.postln;

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


/* Defining and evaluating a function with multiple arguments
   declared unsing the "pipe" syntax */
(
g = { |input1 = 2, input2 = 6|
	var num;
	num = input1.squared;
	num = input2.reciprocal;
};
)

g.value;
g.(5, 10);

5.squared;
25.reciprocal;



5;
5&3; // bitwise AND -> 1




