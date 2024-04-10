/*
 * Tue 02-04-2024
 * UGens
 *
 */
f = {
	arg freq = 800,
	amp = 0.2;
	FSinOsc.ar(freq, 0.0, amp);
}.play;
f.free;

//define a synth
SynthDef.new("FSinOsc-test", { Out.ar(0, FSinOsc.ar(800, 0, 0.02)) }).send(s);
//create an object of it
x = Synth.new("FSinOsc-test");
//free it (stop it from playing)
x.free;

//create and play the synth node using 'messaging style'
n = s.nextNodeID;
s.sendMsg("/s_new", "FSinOsc-test", n);
s.sendMsg("/n_free", n);

/*
 * Wed 03-04-2024
 * UGens
 *
 */
//define a synth
(
SynthDef.new(
	"Theremin",
	{
		Out.ar(0, SinOsc.ar(
			freq: MouseX.kr(300, 2500),
			mul:  MouseY.kr(0, 0.09)
		)
		)
	}
).send(s);
)
//create an object of it
x = Synth.new("Theremin");

//free it
x.free;


/*
 * Sat 06-04-2024
 * UGens, plotting waveforms, polling results
 *
 */

{SinOsc.ar(freq: MouseX.kr(300, 2500), mul: MouseY.kr(0, 0.5))}.scope;

{SinOsc.ar}.play;
{Saw.ar}.scope;
{Pulse.ar}.plot;
{SinOsc.ar(freq:440, mul: 0.3, phase:4).poll}.play;
{LFNoise0.ar(100).poll}.play;


(
SynthDef.new(
	"Bleeper",
	{
		Out.ar(0, SinOsc.ar(
			freq: LFNoise0.kr(4).range(500, 1500),
			mul: 0.1
		)
		)
	}
).send(v);
)

a = Synth.new("Bleeper");
a.free;

/*
 * Mon 08-04-2024
 * scale with range()
 * and mul and add
 */
//this...
{SinOsc.kr(1).range(100, 200).poll}.play;
//...is the same as this
{SinOsc.kr(1, mul: 50, add: 150).poll}.play;

/*
 * Tue 09-04-2024
 * more scaling with range(),
 * also the linlin() method,
 * and mul and add
 */
{SinOsc.kr(1).range(100, 200).poll}.play;
{linlin(SinOsc.kr(0.1), 0, 127).poll}.play;

{LFPulse.kr(1).poll}.play;

{LFPulse.kr(1).linlin(0, 1, 100, 300).poll}.play;

(
{SinOsc.ar(
	freq: LFPulse.kr(1).range(440,880),
	phase: 0.0,
	mul: LFPulse.kr(0.5).range(0.1, 0.3),
	add: 0.0
)
}.play;
)

/*
 * Wed 10-04-2024
 * stopping individual synths,
 * using the set message to
 * change parameters
 * while a synth is playing
 */
//create and assign three synths to separate variables
a = { Saw.ar(LFNoise2.kr(8).range(1000, 2000), mul: 0.2) }.play;
b = { Saw.ar(LFNoise2.kr(7).range(100, 1000), mul: 0.2) }.play;
c = { Saw.ar(LFNoise0.kr(15).range(2000, 3000), mul: 0.1) }.play;
//stop them individually
a.free;
b.free;
c.free;

//The set message
(
x = {
	arg freq = 440,
	amp = 0.1;
	SinOsc.ar(
		freq,
		0,
		amp)
}.play;
)
x.set(\freq, 778);
x.set(\amp, 0.5);
x.set(\freq, 920, \amp, 0.2);
x.free;

//define a synth
(
SynthDef.new("FSinOsc A440",
	{
		arg freq = 440,
		amp = 0.2;
		Out.ar(1,
			FSinOsc.ar(
				freq,
				0,
				amp)
		)
	}
).send(s);
)
//create an instance of it
z = Synth.new("FSinOsc A440");
//set some parameters on the fly
z.set(\freq, 880);
z.set(\freq, 440);
z.set(\amp, 0.4);
z.set(\amp, 0.1);
//stop it
z.free;

/*
 * A wee bit from the SuperCollider book
 * Using an array as the SynthDef freq argument
 */
(
SynthDef(\UGen_ex1b,
	{
		arg freq = [440, 446, 448.5, 882],
		amp = 0.1;
		Out.ar(0, SinOsc.ar(freq, 0, amp))
	}
).send(b);
)
a = Synth.new(\UGen_ex1b);
a.set(\freq, [220, 326, 400, 600]);
a.set(\freq, [440, 446, 448.5, 882]);
a.free;
