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
arg vol = 0.05;
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
vol = 0.9;
x.free;

/*
 * Wed 01-05-2024
 * Continuing the
 * UGens chapter
 */

(
/* added this "arg vol" line below as I was
   trying to create an argument that could be controlled
   on the fly later (see my attempt below at setting vol to 0.9)
   but it doesn't work. It doesn't fail with an error, it just
   doesn't work, so there's obviously some syntax thing I'm
   not doing properly
*/
arg amp = 0.05;
SynthDef.new(
	\kegofbeer,
	{
		Out.ar(0, SinOsc.ar(
			freq: MouseX.kr(100,600),
			mul: MouseY.kr(0, amp)
		)
		)
	}
).send(s);
)

x = Synth.new(\kegofbeer);
x.set(\amp, 0.9); //evaluating this doesn't change the running synth
x.free;

{SinOsc.ar(MouseX.kr(40, 1000, 1), 0, 0.1)}.play;