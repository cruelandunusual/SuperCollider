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
	[neg(a), a.reciprocal ]
}.play;
)


10.rand;

{SinOsc.ar(440).sum3rand}.plot;


0.coin;

{SinOsc.ar(110).coin}.plot;