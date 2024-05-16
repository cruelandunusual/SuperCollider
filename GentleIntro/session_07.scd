/*
 * Tue 14-05-2024
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

/*
 * Wed 15-05-2024
 * more stuff from the
 * first chapter
 */

// 8 The last thing always gets posted
(
"first line".postln;
"Second line".postln;
(2 + 2).postln;
3 + 3;
"Finished".postln;
)

// 11 Recording the output of SuperCollider

// QUICK RECORD
// start recording
s.record;
// Make some sound
{Saw.ar(LFNoise0.kr([2, 3]).range(100, 2000), LFPulse.kr([4, 5]) * 0.1)}.play;
// stop recording
s.stopRecording;
// Optional: GUI with record button, volume control and mute button
s.makeWindow;

// 12 Variables
x = 10;
y = 660;
y;
x;
x + y;
y - x;
x;

a = "Hello world!";
b = [0, 1, 2, 3, 4, 5];
c = Pbind(\note, Pwhite(0, 7), \dur, 0.3);
c.play;
a.postln;
b + 100;
d = b * 5;
d.postln;

~myFreqs = [415, 220, 440, 880, 220, 990];
~myDurations = [0.1, 0.2, 0.2, 0.5, 0.2, 0.1];
Pbind(\freq, Pseq(~myFreqs), \dur, Pseq(~myDurations)).play;

/*
 * Thu 16-05-2024
 * more on global vs local
 * variables
 */

// Environment variables
~galaApples = 4;
~bloodOranges = 5;
~limes = 2;
~plantains = 1;

["Citrus", ~bloodOranges + ~limes];
["Non-citrus", ~plantains + ~galaApples];

// Local variables: valid only within the code block.
// Evaluate the block once and watch the Post window.
(
var apples = 4, oranges = 3, lemons = 8, bananas = 10;
["Citrus fruits", oranges + lemons].postln;
["Non-citrus fruits", bananas + apples].postln;
"End".postln;
)

~galaApples; // still exists
apples; // doesn't exist outside the block

