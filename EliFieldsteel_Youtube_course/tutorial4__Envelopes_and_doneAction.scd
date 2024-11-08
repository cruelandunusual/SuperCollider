x = {SinOsc.ar(440)};
y = x.play;

y.free;

Server.local.plotTree;
s.plotTree;

(
x = {
	var pulseSig, sineSig, output, env;
	env = Line.kr(1, 0, 1, doneAction:2);
	pulseSig = Pulse.ar(ExpRand(30,500)) * env;
	sineSig = SinOsc.ar(ExpRand(220,880)) * env;
	output = pulseSig - sineSig;
};
)

y = x.play;
y.free;