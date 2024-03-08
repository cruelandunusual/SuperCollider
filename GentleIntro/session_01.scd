x = {SinOsc.ar(440*2, 300, 1.0, 1.98)};
y = x.play;
y.free;


{ Blip.ar(Blip.kr(1, 9, 500, 50), 40, 0.5) }.play;

x = {SinOsc.ar};
x.play;


{SinOsc.ar(440*2, 300, 1.0, 0.2)}.play;

(
z = {
	arg noiseHz=8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq) * amp;
}.play;
)
(
SynthDef.new(\sineTest, {
	arg noiseHz=8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\sineTest, [\noiseHz, 4]);

x.free;