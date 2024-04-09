/*
 * Tue 02-04-2024
 * UGens
 *
 */
f = {FSinOsc.ar(800, 0.0, 0.02)};
f.play;
g = f;
g.stop; //this doesn't work - I can't remember the syntax for freeing a synth object

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
