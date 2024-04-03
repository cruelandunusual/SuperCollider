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
			mul:  MouseY.kr(0, 0.05) / 10
		)
		)
	}
).send(s);
)
//create an object of it
x = Synth.new("Theremin");
//free it
x.free;
