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


/******************************/
/* UGen functions             */
/******************************/

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

// Code example 2.5 -- use of set messages with
// a UGen function containing multiple arguments
(
x = {
	| freq = 300, amp = 0.1| // pipe arg format
	SinOsc.ar(mul: amp, freq: freq) ! 2; // frequency always assumed to be first
	// if setting a different order, arguments must all be named with colon syntax
}.play;
)

x.set(\freq, 1700, \amp, 0.2);
x.set(\amp, 0.4, \freq, 660); // order of arguments doesn't matter
x.set(\freq, 200);
x.set(\amp, 0.1);
x.free();


// Code example 2.6 -- function.play construct
// separating defining and playing a UGen function
// into two discrete actions
(
// define the sound
f = { |freq = 300, amp = 0.1|
	SinOsc.ar(freq, mul: amp) ! 2;
};
)

x = f.play;

x.set(\freq, 440);
f.set(\freq, 300, \amp, 0.2); // doesn't affect the synth object x that's playing


// Code example 2.7 -- overriding default argument values
// when calling play on a UGen function
(
f = { |freq = 300, amp = 0.1|
	SinOsc.ar(freq: freq, mul: amp) ! 2;
};
)
x = f.play(args: [freq: 800, amp: 0.2]); //override defaults when calling play
x.set(\freq, 300, \amp, 0.1);

// Code example 2.8 -- using free to stop
// processes individually
(
f = { |freq = 300, amp = 0.1 |
	SinOsc.ar(freq: freq, mul: amp) ! 2;
};
)
x = f.play(args: [freq: 350]);
y = f.play(args: [freq: 450]);
x.free;
y.free;

// Code example 2.9 -- using release to stop processes gradually
(
f = { |freq = 300, amp = 0.1 |
	SinOsc.ar(freq: freq, mul: amp) ! 2;
};
)
x = f.play(args: [freq: 350]);
y = f.play(args: [freq: 450]);
x.release(0.3); // 0.3 secs
y.release(30); // 30 secs


/******************************/
/* Math operations with UGens */
/******************************/

// Code example 2.10 -- using addition to mix a sine wave with pink noise
(
x = {
	var sig;
	sig = SinOsc.ar(1200, mul: 0.15);
	sig = sig + PinkNoise.ar(mul: 0.1);
	sig = sig * 0.1; // make it very quiet (it's already quiet before this
	sig = sig ! 2; // make it stereo
}.play;
)
x.release(0.4);

// Code example 2.11 -- using binary operators as an alternative
// to specifying values for mul and add.
(
x = {
	var sig;
	sig = SinOsc.ar(1200) * 0.15; // alternative way to set the UGen volume using multiplication operator
	sig = sig + PinkNoise.ar * 0.1;
	sig = sig ! 2; // make it stereo
}.play;
)
x.release(0.4);

// tip.rand() -- a UGen function plays the last expression
// The function below only plays the pink noise
(
{
	var sig0, sig1;
	sig0 = SinOsc.ar(300, mul: 0.15) ! 2;
	sig1 = PinkNoise.ar(mul: 0.1) ! 2;
}.play;
)

// This version plays both sine wave and noise
(
{
	var sig0, sig1;
	sig0 = SinOsc.ar(300, mul: 0.15) ! 2;
	sig1 = PinkNoise.ar(mul: 0.1) ! 2;
	sig0 + sig1;
}.play;
)

// Code example 2.12 -- modulating the amplitude of pink noise
// with a low frequency oscillator
(
x = {
	var sig, lfo;
	lfo = SinOsc.kr(freq: 0.2, phase: 3pi/2, mul: 0.1, add: 0.1);
	sig = PinkNoise.ar * lfo;
	sig = sig ! 2;
}.play;
)
x.release(2);

(
x = {
	var sig, lfo;
	lfo = SinOsc.kr(freq: 0.2, phase: 3pi/2, mul: 0.1, add: 0.15); // low frequency oscillator
	sig = SinOsc.ar(freq: 440, phase: 0.0, mul: 0.1, add: 0.0) * lfo; // multiply the audio signal by the lfo
	sig = sig ! 2; // make it stereo
}.play;
)
x.release(2);

// Code example 2.13 -- use of range to specify
// custom output boundaries of a UGen
(
x = {
	var sig, lfo;
	lfo = SinOsc.kr(freq: 0.2, phase: 3pi/2).curverange(0, 0.2, -1);
	sig = (PinkNoise.ar * lfo) ! 2;
}.play;
)
x.release(2);


/******************************/
/* Envelopes                  */
/******************************/

