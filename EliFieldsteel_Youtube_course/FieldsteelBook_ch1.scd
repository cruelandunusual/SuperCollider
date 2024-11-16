~result = 4.squared;
squared(4);
~result.cubed-96.postln;

{SinOsc.ar()}.play;

{SinOscFB.ar()}.play;

SinOsc.browse;

4.class;
"Text".class;
4.0.class;

4.0 * 3.0;

SinOsc.class;

(
{
	var a;
	a = FSinOsc.ar(880);
	[a.neg, a.reciprocal ]
}.play;
)


10.rand;

{SinOsc.ar(440).sum3rand}.plot;


0.coin;

{SinOsc.ar(110).coin}.plot;

1 + 1.0.asBinaryArchive;


345.asBinaryDigits;

Integer.browse;
Float.browse;

345.neg();
neg(345);

/*
nominally at page 17 of Fieldsteel chapter 1
file:///D:/Programming/Supercollider%20Eli%20Fieldsteel-chapter-1.pdf
but I've been digressing with my own stuff a  bit too
*/
