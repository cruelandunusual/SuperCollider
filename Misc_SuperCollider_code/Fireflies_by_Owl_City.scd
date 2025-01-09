(
//code re-creation of the intro to Fireflies by Owl City
//(original video: https://www.youtube.com/watch?v=psuRGfAaju4)
//- Eli Fieldsteel 2020 Oct 25
var bus;
s.newBusAllocators;
bus = Bus.audio(s,2);

s.waitForBoot({

	SynthDef(\ff, {
		arg freq=440, freqtime=0.2, freqcurve=(-50), amp=0.5, out=0;
		var wn, wn_env, wn_fenv, sig, trig;
		trig = Impulse.ar(6);
		wn = WhiteNoise.ar(8!2);
		wn = Pluck.ar(wn, trig, 1/10, 1/(freq*0.6.midiratio), 4, 0.93);
		wn = HPF.ar(wn, 300);
		sig = SinOsc.ar(freq.varlag(freqtime, freqcurve) * (1,3..7));
		sig = sig * (1/(1,3..7)).pow(2.5);
		sig = sig.sum;
		sig = Pan2.ar(sig, {TRand.ar(-0.5,0.5,trig)}!4).sum * 0.5;
		sig = sig + wn;
		sig = sig * amp * 0.13;
		Out.ar(out, sig);
	}).add;

	SynthDef.new(\delverb, {
		arg out=0, in=50;
		var dry, wet, sig, local, local2;
		dry = In.ar(in, 2);
		wet = In.ar(in, 2);
		local = LocalIn.ar(2) + wet;
		local = DelayN.ar(local, 1/2, 1/2 - ControlDur.ir, -6.dbamp);
		local2 = DelayN.ar(local.reverse, 1/2, 1/3 - ControlDur.ir, -9.dbamp);
		local = local + local2;
		LocalOut.ar(local.reverse * -6.dbamp);
		sig = dry + (local * 0.6);
		sig = sig.blend(LPF.ar(GVerb.ar(sig,250,4),1000),0.06);
		Out.ar(out, sig);
	}).add;

	s.sync;

	Synth(\delverb, [\in, bus]);

	s.sync;

	p = Pmono(
		\ff,
		\out, bus,
		\dur, 1/4,
		\amp, Pseq([
			1,1,1,1,1,1,0,1,
			0,1,1,1,1,1,0,1,
			1,1,1,1,1,1,1,1,
			0,1,1,1,1,1,1,1,
			1,1,1,1,1,1,0,1,
			0,1,1,1,1,1,1,1,
			1,0,1,1,0,1,0,1,
			1,0,1,1,0,1,1,1,

		],inf) * 0.3,
		\freq, Pseq([
			58,70,86,58,70,82,82,75,
			75,70,77,75,77,82,82,75,
			56,63,72,70,72,75,63,56,
			56,68,72,70,60,70,75,77,
			58,70,86,74,65,82,75,75,
			75,70,77,75,80,79,75,68,
			56,72,72,63,70,70,63,63,
			72,72,72,70,75,75,77,75,

		],inf).midicps,
		\freqcurve, Pseq([
			Pseq([-50],8),
			Pseq([-50,-50,-50,-20,-20,-20,-50,-50],1),
			Pseq([-50],8),
			Pseq([-50,-50,-50,-50,-50,-50,-20,-50],1),
			Pseq([-50],8),
			Pseq([-50,-50,-50,-20,-20,-20,-50,-50],1),
			Pseq([-50],8),
			Pseq([-50,-50,-50,-50,-50,-50,-20,-20],1),

		],inf),

	).play(TempoClock.new(3/2));
});
)