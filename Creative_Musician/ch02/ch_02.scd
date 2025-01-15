s.boot;
s.quit;
s.plotTree;
s.sampleRate;
s.options.blockSize;


// phase is in radians; SC has keyword pi,
// so this statement is valid
{SinOsc.ar(440, phase: pi/4, mul:0.2)}.play;

// LFTri has iphase instead of phase
{LFTri.ar(440, iphase: 4)}.play;

// Use this to calibrate hardware volume levels
{PinkNoise.ar(mul:1) ! 2}.play;


// Code example 2.1
{SinOsc.ar(freq:300, phase:0, mul:0.1, add:0)}.play; // left speaker only

// Code example 2.2 / 2.3
// ! 2 is shortcut for duplication; it creates two UGens, which SC interprets
// as a multichannel signal, and routest them through left and right speakers
{SinOsc.ar(freq:300, phase:0, mul:0.1, add:0) ! 2}.play;


// Code example 2.4 -- playing a UGen function and
// using set to change the sound (in this case the freq being played
(
x = {
	| freq = 300| // pipe arg format
	SinOsc.ar(freq, mul:0.1) ! 2;
}.play;
)

x.set(\freq, 1700);
x.free();