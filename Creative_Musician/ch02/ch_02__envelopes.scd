(
x = {
	var signal, envelope, duration;
	duration = 40;
	envelope = Line.kr(start:0.3, end:0, dur:duration);
	(signal = SinOsc.ar(Line.kr(100, 440, duration), mul:0.2) * envelope)!2;
}.play;
)

x.release(1);