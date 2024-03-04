x = {SinOsc.ar(440*2, 300, 1.0, 1.98)};
y = x.play;
y.free;


{ Blip.ar(Blip.kr(1, 9, 500, 50), 40, 0.5) }.play;

x = {SinOsc.ar};
x.play;