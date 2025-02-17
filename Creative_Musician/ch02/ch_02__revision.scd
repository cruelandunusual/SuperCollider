{Pulse.ar(freq:440, width:0.9, mul:0.2)!2}.play;
{Saw.ar(freq:440, mul:0.2)!2}.play;
{SinOsc.ar(freq:440, phase:2pi, mul:0.2)!2}.play;
{SinOsc.ar(freq:440, mul:0.2)!2}.play;

{LFTri.ar([400,600].choose, iphase:0, mul:0.2)!2}.play;


{[SinOsc.ar(freq:440, phase:0.0, mul:0.2), VarSaw.ar(freq:440, mul:0.2)]}.scope;

FreqScope.new;

(
{
	//some code
}.scope;
)



/*********************************

   Subtractive Synthesis - from
   https://composerprogrammer.com/teaching/supercollider/sctutorial/2.1%20Subtractive%20and%20Additive%20Synthesis.html


**********************************/

// Pure white noise, equal energy at all spectral frequencies
{WhiteNoise.ar(mul:0.1)!2}.scope; // .scope plays the function AND opens a scope. Who knew!?

// Filtered with a low pass filter
// the WhiteNoise UGen is 'passed to' the LPF UGen as a parameter
{LPF.ar(WhiteNoise.ar(mul:0.1), freq:1000, mul:1.0)!2}.scope;
// the freq value is the filter cutoff, here it's fixed at 2000

// if we want to vary the filter cutoff we can use a Line generator UGen
// plugged in to the freq argument slot
{Line.ar(start: 5000, end: 1, dur: 1, mul: 0.2, doneAction:0)}.scope;

// but note we're using the kr method of the Line generator,
// not the ar method (which does create sound on its own as above, but it's a brief click
{LPF.ar(WhiteNoise.ar(mul:0.1), XLine.kr(10000.0, 2.0, 12), mul:1.0)!2}.scope;

// Another example of plugging a sound source (LFNoise0) into a filter (Resonz), with XLine to change the filter frequency
{Resonz.ar(in: LFNoise0.ar(freq: 400), freq: XLine.kr(start: 10000.0, end: 1000.0, dur: 10.0), bwr: 0.1)!2}.scope;
// This is more readable with local variables holding object references as we build the patch
(
{
	var soundSource, filterFreq, filter;
	soundSource = LFNoise0.ar(freq: 400);
	filterFreq = XLine.kr(start: 10000.0, end: 1000.0, dur: 10.0);
	filter = Resonz.ar(in: soundSource, freq: filterFreq, bwr: 0.1); // bwr = Bandwidth ratio (reciprocal of Q). rq = bandwidth / centerFreq.
	filter.dup(2);
}.scope;
)





