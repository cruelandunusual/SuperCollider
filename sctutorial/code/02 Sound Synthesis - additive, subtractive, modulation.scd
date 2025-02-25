

Sound Synthesis in SuperCollider: Subtractive and Additive Synthesis
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
		var mult = ((-1)**i)*(0.5/((i+1)));
		SinOsc.ar(440*(i+1))*mult;
	});
	Pan2.ar(wave/n,0.0); //stereo, panned centre
}.scope;
)

{Saw.ar(freq:440, mul:0.1)!2}.scope;
