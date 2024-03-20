/*
 * Tue 19-03-2024
 * (Re)Learning about patterns
 *
 */

Pbind(\degree, Pseries(-10, 2, 25), \dur, 0.15).play;

(
Pbind(
	\degree, Pseq([0,1,2,3,4,5,6,7].reverse(), 1),
	\dur, 0.2,
	\amp, 0.4
).play;
)


Pbind(\degree, 1, \dur, 1).play;

/*
 * Wed 20-03-2024
 * (Re)Learning about patterns
 *
 */
(
Pbind(
	\freq, Pseq([220, 280, 440, 600, 378, 400, 267, ], 5),
	//\dur, Pseq([0.2, 0.1, 0.25, 0.3], inf)
	\dur, 0.5
).play;
)

(
Pbind(
	\note, Pseq([[0, 3, 4], [3, 6, 7], [0, 3, 4]], 3),
	\dur, 1,
).play;
)

Pbind(\degree, 5).play;

Pbind(\note, 9).play;

Pbind(\midinote, 69).play;

Pbind(\freq, 440).play;