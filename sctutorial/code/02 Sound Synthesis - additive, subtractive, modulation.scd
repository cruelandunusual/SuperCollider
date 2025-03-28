/*********************************

2.1 Subtractive and Additive Synthesis
from Nick Collins' SuperCollider tutorials
[ composerprogrammer.com ]

**********************************/

FreqScope.new; // open a Frequency analyser

(
{
	//some code
}.scope;
)



/*********************************

Subtractive Synthesis
In subtractive synthesis, we start
with a complex source, and we subtract
parts from this raw sound to make
a more sculpted sound.
This is also termed a source+filter model.

**********************************/

// Pure white noise, equal energy at all spectral frequencies
{WhiteNoise.ar(mul:0.1)!2}.scope; // .scope plays the function AND opens a scope. Who knew!?

// Filtered with a low pass filter
// the WhiteNoise UGen is 'passed to' the LPF UGen as a parameter
{LPF.ar(WhiteNoise.ar(mul:0.1), freq:2000, mul:1.0)!2}.scope;
// the freq value is the filter cutoff

// if we want to vary the filter cutoff we can use an XLine generator UGen
// plugged in to the freq argument slot
{XLine.ar(start:5000, end:1, dur:1, mul:0.002, doneAction:0)}.scope; // mul:0.002 to get rid of the loud click
// the code above shows the frequency of the line filter

// but note we're using the kr method of the Line generator,
// not the ar method shown above (which does create sound on its own, but it's a brief click)
{LPF.ar(WhiteNoise.ar(mul:0.1), XLine.kr(start:10000.0, end:2.0, dur:12), mul:1.0)!2}.scope;


// all of this code is more readable when spaced out like this:
{
	LPF.ar(
		in: WhiteNoise.ar(mul:0.1), // input signal
		freq: XLine.kr(start:10000.0, end:2.0, dur:12), // XLine varies over time, so the LPF freq will vary over time
		mul:1.0 // output multiplied by this value
	).dup(2); //could use !2 here instead of dup method
}.scope;


// Another example of plugging a sound source (LFNoise0) into a filter (Resonz), with XLine to change the filter frequency
(
{
	Resonz.ar(
		in: LFNoise0.ar(freq:400, mul:1.0),//(freq:400),
		freq: XLine.kr(start:10000.0, end:1000.0, dur:10.0),
		bwr:0.2).dup(2);

}.scope;
)

/*
There are lots of possible sources and lots of possible filters

some example sources:
Oscillators:
Saw
Blip

Noise Sources:
PinkNoise
LFNoise0

some example filters:
HPF
BPF
Resonz
*/


// This is more readable with local variables holding object references as we build the patch
// Also, for revision purposes I set a variable (f) to hold the function definition and created
// another variable (g) to play the function definition
(
f = {
	 |filtStart = 100.0, filtEnd = 10000.0, filtDur = 5.0| // somehow this arg syntax seems to allow overriding
	// more easily than declaring arg names as below: ...?
	//arg filtStart, filtEnd, filtDur;
	var soundSource, filterFreq, filter;
	// default values for the filter (if using arg declarations instead of pipe syntax)
	//filtStart = 1000.0;
	//filtEnd = 10000.0;
	//filtDur = 5.0;

	soundSource = LFNoise0.ar(freq:400, mul:0.2);
	filterFreq = XLine.kr(start:filtStart, end:filtEnd, dur:filtDur);
	filter = Resonz.ar(in:soundSource, freq:filterFreq); // bwr = Bandwidth ratio (reciprocal of Q). rq = bandwidth / centerFreq.
	filter.dup(2);
};
)
g = f.play;
g = f.play(args: [filtStart:1000.0, filtEnd:1.0, filtDur:5.0]); //override defaults when calling play
g.free;


/*********************************

Additive Synthesis
Rather than starting with something
complex and taking energy away to
sculpt a sound, we can start with simple
building blocks and add many of them
together to create more involved sounds

**********************************/

// The classic building block in computer music is the sine tone
{SinOsc.ar}.scope;

// A method of getting two sine tones at once:
(
{
	SinOsc.ar(freq:400, phase:0.0, mul:0.1)
	+
	SinOsc.ar(freq:660, phase:0.0, mul:0.1);
}.scope;
)

// An even easier way is to hold the frequencies in an array
// This also sounds better stereo-wise
(
{
	SinOsc.ar(freq:[400,660], phase:0.0, mul:0.1);
}.scope;
)

// To understand what happened to the stereo field in that last example,
// let's look at a panning UGen
(
{
	Pan2.ar(
		in:SinOsc.ar(freq:440, mul:0.1),
		pos:MouseY.kr(minval:-1, maxval:1));
}.scope;
)

// The panner takes a mono signal and places it in the stereo field.
// The Mouse UGen pans signal from left or right depending on y position of the mouse.

// We can also do more than two channels, even if we can only hear the first two:
{SinOsc.ar(freq:[200, 450, 700], mul:0.1)}.scope;

// To hear more than two channels we can mix the signals
// down to mono using a Mix UGen
{Mix(array:SinOsc.ar(freq:[200, 450, 700], mul:0.1))}.scope;

// To hear this as stereo we can wrap it in the Pan2 UGen
(
{
	Pan2.ar(
		in:Mix(SinOsc.ar(freq:[200, 450, 700], mul:0.1)),
		pos:MouseY.kr(minval:-1, maxval:1));
}.scope;
)

// two signals differing in frequency by 1Hz
(
x = {
	var freq, signal_1, signal_2, output;
	freq = 440;
	signal_1 = SinOsc.ar(freq:freq, mul:0.1);
	signal_2 = SinOsc.ar(freq:freq+1, mul:0.1);
	output = signal_1 + signal_2;
	output !2;
}.scope;
)

/*

We are now equipped to explore additive synthesis via sine tones.
In additive synthesis, if we know a recipe for the spectrum
(frequency content) of a sound, we can synthesise it by adding up
sine tones for each component frequency.

Recipes for common waveforms are known from the Fourier theory
of sound (sinusoids at which frequencies and amplitudes add up
to create certain waveform shapes).

*/

/*
Sawtooth wave: Add up n harmonics with amplitude falling off
as 1/harmonicnumber, sign alternates between +1 and -1
*/
(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|
		var mult = ((-1)**i)*(0.5/((i+1))); //amplitude
		SinOsc.ar(440*(i+1))*mult;
	});
	Pan2.ar(wave/n,0.0); //stereo, panned centre
}.scope;
)

{Saw.ar(freq:440, mul:0.1)!2}.scope;


/*
Square wave: Sum of odd harmonics, no even, amplitude
falls as off 1/harmonicnumber; closest 'real' waveform
is a clarinet tone
*/
(
{
	var n = 10;
	var wave = Mix.fill(10,{|i|
			var harmonicnumber = 2*i+1; //odd harmonics only
			SinOsc.ar(440*harmonicnumber)/harmonicnumber
		})*0.05;
	Pan2.ar(wave,0.0); //stereo, panned centre
}.scope;
)

LF



// This is my own attempt at making lots of SinOsc signals; no attempt at
// doing anything fancy with the harmonics, I mainly wanted to know
// if the 10 signals created by Mix.fill would all have 10 different frequencies (they do).
(
f = {
	var n = 20;
	var sig = Mix.fill(n, {SinOsc.ar(freq:rrand(100, 800), mul:0.2/n)});
	Pan2.ar(sig);
};
)

g = f.play;

/*********************************

2.2 mul and add (and arguments to UGens)
from Nick Collins' SuperCollider tutorials
[ composerprogrammer.com ]

**********************************/

// mul and add are usually the final arguments to UGens.
// mul scales the amplitude of the signal that's sent to the soundcard.
// add is a value added to every sample in the output signal.

// In this example the mouseY location multiplies (amplifies) the output.
{SinOsc.ar(mul:MouseY.kr(minval:0.3, maxval:0.01))!2}.scope;



// Another thing you can do to signals is offset (translate) them.
// This example uses the add argument for this.
{SinOsc.ar(mul:0.1, add:MouseY.kr(minval:0.9, maxval:-0.9))}.scope;
// This doesn't affect the sound of the output. From Fieldsteel page 41:
/* "If add is non-zero, the entire waveform vertically shifts... A vertically
shifted signal may not sound any different to the human ear, but if routed
through a loudspeaker the speaker cone will vibrate asymetrically, which may
fatigue or distress the speaker over long periods of time..." */

// The mul and add arguments help when you need to set one signal as an input to another
// and need to scale the input signal appropriately to the expected input values required.
{SinOsc.ar(mul:MouseX.kr(minval:0.03, maxval:0.2), add:MouseY.kr(minval:0.9, maxval:-0.9))}.scope;
// In this example, the output signal (default value of 1.0) is being multiplied by the MouseX UGen,
// with the minimum and maximum values constrained to be much lower than 1.0



// There is a shortcut for the mul and add inputs given by using the * and + symbols.
{0.1*SinOsc.ar}.scope;
// is the same as
{SinOsc.ar*0.1}.scope;
// which is the same as
{SinOsc.ar(mul:0.1)}.scope;
// And
{0.1*SinOsc.ar+0.5}.scope;
// is the same as
{SinOsc.ar*0.1+0.5}.scope;
// which are both equivalent to
{SinOsc.ar(mul:0.1,add:0.5)}.scope;



// A note on modulation (you may find it useful to reread this later):
// mul and add are very useful in setting up modulators, sometimes via the * and + versions.
// The mul input in particular gets used for explicit modulation, that is, multiplying different signals together.
// Using one SinOsc to modulate the frequency of another:
(
{SinOsc.ar(
	SinOsc.kr( // this can also be the .ar method, but since we're
		// plugging in a very low frequency it might as well be .kr
		freq:3, // 3 oscillations per second
		mul:40,
		add:440),
	phase:0,
	mul:0.1)
}.scope;
)
// The inner SinOsc is the modulator. Three times per second it varies between +-40 (mul scaling).
// I add 440 to make this output value go between 400 and 480.
// This is a suitable input varying frequency control for the outer SinOsc.

/*********************************

2.3 Controlling Synths
from Nick Collins' SuperCollider tutorials
[ composerprogrammer.com ]

**********************************/

// Store a reference to a running synth:
a = {SinOsc.ar(freq:440)*0.2 !2}.scope;
a.run(false);
a.run;
a.free;

// an argument to a function is a way to control a synth parameter
a = {arg wave = 440, amp = 0.2; SinOsc.ar(wave)*amp !2}.play;
a.run(false);
a.set(\wave, 1000);
a.run;

a.set(\wave, rrand(220,440), \amp, rrand(0.05, 0.2));



/*********************************

2.4 Modulation Synthesis
from Nick Collins' SuperCollider tutorials
[ composerprogrammer.com ]

**********************************/

// In modulation synthesis one wave, the carrier, is influenced (modulated) by a second, the modulator.
// Ring modulation - a straight multiplication of two signals
// carrier * modulator
(
{
	var carrier, modulator, carrierFreq, modulatorFreq;
	carrierFreq = MouseX.kr(minval:440, maxval:5000, warp:'exponential');
	modulatorFreq = MouseY.kr(minval:1, maxval:5000, warp:'exponential');
	carrier = LFSaw.ar(freq:carrierFreq, mul:0.2);
	modulator = LFSaw.ar(freq:modulatorFreq, mul:0.2);
	Pan2.ar(in:carrier * modulator, pos:0.0, level:1.0);
}.scope;
)

(
{
	var freq, freqMult, carrier, modulator, output;
	freq = 300;
	freqMult = 4;
	carrier = SinOsc.ar(freq:freq);
	modulator = SinOsc.ar(freq:freq * freqMult);
	output = carrier * modulator;
	Pan2.ar(in:output, pos:0.0, level:0.2);
}.scope;
)

c = 300;
m = 4;
n = c*m;



