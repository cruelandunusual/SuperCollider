/*
A basic amplitude envelope created by Line.kr
doneAction:2 removes the sound process
from the server when it terminates
*/
(
x = {
	var signal, envelope, duration;
	duration = 4;
	envelope = Line.kr(start:0.3, end:0, dur:duration, doneAction:2);
	(signal = SinOsc.ar(Line.kr(100, 440, duration), mul:0.2) * envelope)!2;
}.play;
)

x.release(1);

/*
Env and EnvGen are more flexible as envelopes
*/

(
e = Env.new(
	levels: [0, 1, 1, 0],
	times: [1, 5, 3],
	curve: [\sin, \lin, \sin]
);

e.plot;
)

/*
Using Env and EngGen together
*/

(
{
	var sig, mod, env, output;
	env = EnvGen.kr(
		envelope: Env.new(
			levels: [0, 1, 0],
			times: [1, 3],
			curve: [\sin, \sin]
		),
		doneAction: 2 // 2 -> free the synth when finished
	);
	sig = SinOsc.ar(350) * 0.2;
	mod = SinOsc.ar(freq: 100);
	output = ((sig * mod) * env) ! 2;
}.play;
)

