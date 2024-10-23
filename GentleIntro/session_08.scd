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

{RLPF.ar(Dust.ar([100, 500]), LFNoise1.ar([0.3, 0.2]).range(100, 3000), 0.02)}.play;
s.volume.gui;