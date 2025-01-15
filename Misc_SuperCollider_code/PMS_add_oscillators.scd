( // add Oscillator signals together
x = {
	var sig;
	sig = SinOsc.ar(440, 0.2, 0.5, 0.5);
	//sig = SinOsc.ar(490, 0.2, 0.5, 0.5);
	sig = sig + Blip.ar(220, 0.2, 0.5, 0.5);
	sig = sig + Saw.ar(110, 0.2, 0.5, 0.5);
	sig = sig + LFTri.ar(freq: 440, iphase: 0.0, mul: 1.0, add: 0.0);

}
)
y = x.play;
y.free;
