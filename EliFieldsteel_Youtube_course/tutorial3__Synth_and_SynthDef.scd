
s.plotTree;
ServerOptions.devices;
Server.default.options.device = "Windows DirectSound";
Server.default.options.device = "MME";
Server.default.options.device = "Windows WASAPI";
Server.default.options.device = "ASIO : ASIO4ALL v2"; // use this for no conflicts with browser
Server.default.options.device = "ASIO : Generic Low Latency ASIO Driver";
s.boot;


/*
 UGen function
*/
(
z = { //make a function with curly brackets
	arg noiseHz = 8; //declare args before vars
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise0.kr(12).exprange(0.02,0.75);
	sig = SinOsc.ar(freq) * amp;
}.play;
)
z.free;


/*
 The same UGen function as a SynthDef
*/
(
SynthDef.new(\sineTest, {
	/*
	 *SynthDef.new creates a synthdef from a UGen function;
	 *give it a name using the backslash char (or quotes)
	 */
	arg noiseHz = 8; //declare args before vars
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise0.kr(12).exprange(0.02,0.75);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\sineTest);
x.free;


(
SynthDef.new(\sawTest, {
	/*
	 *SynthDef.new creates a synthdef from a UGen function;
	 *give it a name using the backslash char (or quotes)
	 */
	arg noiseHz = 8; //declare args before vars
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise0.kr(12).exprange(0.02,0.75);
	sig = Saw.ar(freq) * amp;
	Out.ar(0, sig);
}).add;
)

y = Synth.new(\sawTest);
y.free;


