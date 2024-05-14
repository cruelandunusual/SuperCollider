/*
 * Tue 14-04-2024
 * Back to the start of the
 * book!
 */

"Hello World!".postln;

{SinOsc.ar}.play;
s.volume.gui;//make a volume slider for convenience

/*
code copied from the
book but I've broken
onto multiple lines and
named the arguments
*/

(
{
	SinOsc.ar(
		freq: LFNoise0.kr(10).range(500, 1500),
		mul: 0.1)
}.play;
)
////////////////////////
(
{
	RLPF.ar(
		in: Dust.ar(density: [12,15]),
		freq: LFNoise1.ar(freq: [0.3, 0.2]).range(100, 3000),
		rq: 0.02)
}.play;
)

5 + 2 * 2; //order of evaluation - result here is 14

5 + (2 * 2); //use parentheses to force specific order. Result is 9

