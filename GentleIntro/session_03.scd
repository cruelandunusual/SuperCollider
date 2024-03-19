/*
 * Tue 19-03-2024
 * (Re)Learning about patterns
 *
 *
 */

Pbind(\degree, Pseries(-10, 2, 25), \dur, 0.15).play;

(
Pbind(
	\degree, Pseq([0,1,2,3,4,5,6,7], 1),
	\dur, 0.2,
	\amp, 0.4
).play;
)


Pbind(\degree, 0, \dur, 1).play;
