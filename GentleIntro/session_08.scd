/*
Starting the Gentle Introduction book
from the start. Some of it's coming back to me,
I'll probably get to where I left it before
a lot more quicly this time
*/

(
{SinOsc.ar}.play;
s.volume.gui;
)


/////////
(
{
	SinOsc.ar(
		LFNoise0.kr(100).range(500, 1500),
		mul: 0.1)
}.play;
)
/////////

~a = rrand(30,70);
~b = rrand(1000,3000);
(
{RLPF.ar(Dust.ar([100, 500]), LFNoise0.ar([0.3, 0.2]).range(~a, ~b), 0.02)}.play;
s.volume.gui;
)

rrand(10,20);

5 + 2 * 2.squared;



{Saw.ar(LFNoise0.kr([5,9]).range(~a,~b),LFPulse.kr([4,5]) * 0.1)}.play;

x = 10;
x==10;

