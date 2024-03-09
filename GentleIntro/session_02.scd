(
var deg;
deg = 7;
x = Pbind(
	\degree, Pseq([[0,1,2], [3,4,5], [6,7,7], [6,5,4], [3,2,1,0]], 2),
	\dur, 0.2,//Pseq([0.1,0.9,0.5,0.2,0.01,0.1,0.2,0.91], inf),
	\amp, Pseq([0.2,0.04,0.07,0.3], inf),
	\legato, 0.6
);

x.play;
)



Pbind(\degree, 5).play;
Pbind(\note, 9).play;
Pbind(\midinote, 69).play;
Pbind(\freq, 440).play;

