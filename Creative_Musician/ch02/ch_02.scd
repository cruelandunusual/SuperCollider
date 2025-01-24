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

// Code example 2.14 -- usage of line and xline as
// simple amplitude envelopes
(
x = {
	var sig, env;
	env = Line.kr(start: 0.4, end: 0.0, dur: 1.0, doneAction: 2); // doneAction 2 frees the synth from the server
	sig = (SinOsc.ar(freq: 440) * env) ! 2;
}.play;
)

(
x = {
	var sig, env;
	env = XLine.kr(start: 0.6, end: 0.0001, dur: 1.0, doneAction: 2); // end value of XLine can't be zero
	sig = (SinOsc.ar(freq: 440) * env) ! 2;
}.play;
)

// Code example 2.16 -- creating and plotting an
// instance of Env
(
e = Env.new(levels: [0, 0.5, 0], times: [1, 3], curve: [8, -8]);
e.plot;
)

// Code example 2.17 -- usage of Env and EnvGen to
// create a custom amplitude envelope signal
(
f = {
	var sig, env;
	env = EnvGen.kr(
		envelope: Env.new(
			levels: [0, 1, 0],
			times: [1, 3],
			curve: \sin
		),
		doneAction: 2 );
	sig = SinOsc.ar(freq: 440) * 0.3; // set amplitude of 0.3
	sig = sig * env;
	sig = sig ! 2;
};
)
f.play;
f.plot;

// Code example 2.18 -- usage of Env and EnvGen
// to create a gated envelope
(
f = { |gate = 1, freq = 440|
	var sig, env;
	env = EnvGen.kr(
		envelope: Env.new(
			levels: [1, 0.3, 0.2, 0],
			times: [3, 0.3, 1],
			curve: [0, -1, -4],
			releaseNode: 2
		),
		gate: gate,
		doneAction: 0 );
	sig = SinOsc.ar(freq: freq) * 0.3; // set amplitude of 0.3
	sig = sig * env;
	sig = sig ! 2;
};
)

x = f.play;
x.set(\gate, 0);
x.free();

// Code example 2.19 -- a retriggerable gated envelope
(
f = { |gate = 1, freq = 440|
	var sig, env;
	env = EnvGen.kr(
		envelope: Env.new(
			levels: [1, 0.3, 0.2, 0],
			times: [3, 0.3, 1],
			curve: [0, -1, -4],
			releaseNode: 2
		),
		gate: gate,
		doneAction: 0 );
	sig = SinOsc.ar(freq: freq) * 0.3; // set amplitude of 0.3
	sig = sig * env;
	sig = sig ! 2;
};
)

x = f.play;
x.set(\gate, 0);
x.set(\gate, 1);
x.set(\freq, 330);
x.set(\freq, 660);
x.free();

// Code example 2.20 -- use of trigger-type arguments
// to create a retriggerable fixed-duration envelope
(
x = { |t_gate = 0|
	var sig, env;
	env = EnvGen.kr(
		envelope: Env.new(
			levels: [0, 1, 0],
			times: [0.2, 0.3],
			curve: [0, -4],
		),
		gate: t_gate,
	);
	sig = SinOsc.ar(350) * 0.3;
	sig = sig * env;
	sig = sig ! 2;
}.play;
)
x.set(\t_gate, 1); // evaluate repeatedly
x.free;



/*************************************************************/
/*                                                           */
/* PMS mucking about with different Env types (perc, etc)    */
/*                                                           */
/*************************************************************/

(
x = { |t_gate = 0|
	var sig, env;
	env = EnvGen.kr(
		envelope: Env.perc(
		),
		gate: t_gate,
	);
	sig = SinOsc.ar(350) * 0.3;
	sig = sig * env;
	sig = sig ! 2;
}.play;
)
x.set(\t_gate, 1); // evaluate repeatedly
x.free;




(
e = Env.new(levels: [0, 0.5, 0], times: [1, 3], curve: [-8, -8]);
e.plot;
)


(
x = {|t_gate = 0|
	var sig, env;
	env = EnvGen.kr(
		//envelope: Env.adsr,
		envelope: Env.adsr(
			attackTime: 0.01,
			decayTime: 0.9,
			sustainLevel: 1.0,
			releaseTime: 0.2,
			peakLevel: 1.0,
			curve: -4.0,
			bias: 0.0
		),
		gate: t_gate,
		doneAction: 0
	);
	sig = SinOsc.ar(mul: 0.8);
	sig = sig * env;
	sig = sig ! 2;
}.play;
)
x.set(\t_gate, 1);
x.free;


/* plotting this envelope to work out why it produces such a quiet sound.
The only value that's different from the default here is attackTime.
I think a longer attackTime (as I've done with 0.9) doesn't work because it never
has enough time to get to the max level. Just a thought though; when I plot it I can't
see any obvious reason why it sounds so quiet*/
(
e = Env.adsr(
	attackTime: 0.01,
	decayTime: 0.9,
	sustainLevel: 1.0,
	releaseTime: 0.2,
	peakLevel: 1.0,
	curve: -4.0,
	bias: 0.0
);
e.plot;
)




// From the Env help file:
(
SynthDef(\env_help, { |out, gate = 1, amp = 0.1, release = 0.1|
    var env = Env.adsr(0.02, release, amp);
    var gen = EnvGen.kr(env, gate, doneAction: Done.freeSelf);
    Out.ar(out, PinkNoise.ar(1 ! 2) * gen)
}).add
);

a = Synth(\env_help);
b = Synth(\env_help, [\release, 2]);
a.set(\gate, 0); // alternatively, you can write a.release;
b.set(\gate, 0);



/*
Testing if Env works in place of EnvGen -- it doesn't;
an Env is used within an EnvGen
*/
(
x = {|t_gate = 0, freq = 440|
	var sig, env;
	e = Env.new([0.001,0.7,0.001], [0.002,0.3], \sin);
	env = EnvGen.kr(
		e,
		gate: t_gate,
		doneAction: 0
	);
	sig = SinOsc.ar(freq: freq, mul: 0.8);
	sig = sig * env;
	sig = sig ! 5;
}.play;
)
x.set(\t_gate, 1, \freq, 515);
x.free;

/*************************************************************/
/*                                                           */
/* PMS end of mucking about                                  */
/*                                                           */
/*************************************************************/

/******************************/
/* Multichannel signals       */
/******************************/

// a simple UGen plays from the left speaker only
{LFSaw.ar(440, mul:0.05)}.play;

// the dup method (or its symbolic shortcut, below, creates two UGens,
// which SC plays on channels 0 and 1, corresponding to left and right
{LFSaw.ar(440, mul:0.05)! 2}.play;

// Code example 2.21 -- step-by-step depiction of multichannel expansion
// This statement
{SinOsc.ar([350,353]) * 0.2}.play;
// is equivalent to
{[SinOsc.ar(350), SinOsc.ar(353)] * 0.2}.play;
//which is also equivalent to
{[SinOsc.ar(350) * 0.2, SinOsc.ar(353) * 0.2]}.play;


// Code example 2.22 -- UGen function involving a binary operation
// between two multichannel signals. The 450 Hz tone is modulated
// by a 1 Hz oscillator and the 800 Hz tone is modulated by
// a 9 Hz oscillator
(
{
	var sig, mod;
	sig = SinOsc.ar([450, 800]);
	//mod = SinOsc.kr([1, 9], mul:1.0);
	mod = SinOsc.kr([1, 9]).range(0, 1);
	sig = sig * mod;
	sig = sig * 0.2;
}.play;
)
