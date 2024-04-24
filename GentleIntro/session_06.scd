/*
 * Tue 23-04-2024
 * Back to the start of the
 * UGens chapter
 */

{ SinOsc.ar }.plot;

{ SinOsc.ar(freq: MouseX.kr(100,600), mul: MouseY.kr(0, 0.03)) }.play;

{ Pulse.ar(freq: MouseX.kr(100,600, warp: 2), mul: 0.03) }.scope;

//define a synth
/*
I tried to remember the syntax for defining
a synth - I got close but I had to revert to
some old examples I wrote to get it correct
*/
(
SynthDef.new(
	\kegofbeer,
	{
		Out.ar(0, SinOsc.ar(
			freq: MouseX.kr(100,600),
			mul: MouseY.kr(0, 0.03)
		)
		)
	}
).send(s);
)

x = Synth.new(\kegofbeer);
x.free;
