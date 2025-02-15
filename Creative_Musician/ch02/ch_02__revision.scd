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

/* Subtractive Synthesis - from
   https://composerprogrammer.com/teaching/supercollider/sctutorial/2.1%20Subtractive%20and%20Additive%20Synthesis.html
*/

// Pure white noise, equal energy at all spectral frequencies
{WhiteNoise.ar(mul:0.1)!2}.scope;

// Filtered with a low pass filter
// the WhiteNoise UGen is 'passed to' the LPF UGen as a parameter
{LPF.ar(WhiteNoise.ar(mul:0.1), freq:2000, mul:1.0)}.scope;
// the freq value is the filter cutoff, here it's fixed at 2000

// if we want to vary the filter cutoff we can use a Line generator UGen
// plugged in to the freq argument slot
{Line.ar(start: 5000, end: 1, dur: 1, mul: 0.2, doneAction:0)}.scope;

// but note we're using the kr method of the Line generator,
// not the ar method (which does create sound on its own as above, but it's a brief click
{LPF.ar(WhiteNoise.ar(mul:0.1), Line.kr(10000, 2, 2), mul:1.0)}.scope;





/////////////
(
{
Mix(
	Resonz.ar(			//The Resonz filter has arguments input, freq, rq=bandwidth/centre frequency
		Saw.ar([440,443,437] + SinOsc.ar(100,0,100)), //frequency modulated sawtooth wave with chorusing
		XLine.kr(10000,10,10), //vary filter bandwidth over time
		Line.kr(1,0.05, 10), //vary filter rq over time
		mul: LFSaw.kr(Line.kr(3,17,3),0,0.5,0.5)*Line.kr(1,0,10)  //AM
	)
)
}.scope
)
/////////////////////

(
var w, carrfreqslider, modfreqslider, moddepthslider, synth;
w=Window("frequency modulation", Rect(100, 400, 400, 300));
w.view.decorator = FlowLayout(w.view.bounds);
synth= {arg carrfreq=440, modfreq=1, moddepth=0.01;
SinOsc.ar(carrfreq + (moddepth*SinOsc.ar(modfreq)),0,0.25)
}.scope;
carrfreqslider= EZSlider(w, 300@50, "carrfreq", ControlSpec(20, 5000, 'exponential', 10, 440), {|ez|  synth.set(\carrfreq, ez.value)});
w.view.decorator.nextLine;
modfreqslider= EZSlider(w, 300@50, "modfreq", ControlSpec(1, 5000, 'exponential', 1, 1), {|ez|  synth.set(\modfreq, ez.value)});
w.view.decorator.nextLine;
moddepthslider= EZSlider(w, 300@50, "moddepth", ControlSpec(0.01, 5000, 'exponential', 0.01, 0.01), {|ez|  synth.set(\moddepth, ez.value)});
w.front;
)
