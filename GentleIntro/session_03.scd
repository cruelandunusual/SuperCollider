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

/*
 * Thu 21-03-2024
 * (Re)Learning about patterns
 *
 */

(
var time=0.2;
Pbind(
	\note, Pseq([[0, 3, 7], Rest(time), [2, 5, 8], [3, 7, 10], [5, 8, 12], Rest(time)], 3),
	\dur, 0.22,
	\legato, 0.3,
	\strum, 0.1 // try 0, 0.1, 0.2, etc
).play;
)

/*
 * Fri 22-03-2024
 * (Re)Learning about patterns
 *
 */
(
Pbind(
	/*
	when you don't explicitly
	specify a scale, Scale.major
	is assumed
	*/
	//\scale, Scale.melodicMinor,
	//\scale, Scale.major,
	//\scale, Scale.iwato,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
	\dur, 0.15;
).play
)


Scale.directory; //evaluate this for a list of all available scales

(
Pbind(
	/*
	3.1 after 3 means one
	chromatic step above 3,
	in this case F# above F
	*/
	\degree, Pseq([0, 1, 2, 3, 3.1, 4], 1),
).play;
)


(
Pbind(
	//scale, Scale.major,
	//\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
	\note, Pser([0, 2, 3, 5, 7, 8, 11, 12], 8),
	\ctranspose, 0, //transpose an octave above (= 12 semitones)
	\dur, 0.15;
).play;
)

/*
 * Mon 25-03-2024
 * (Re)Learning about patterns
 *
 */
(
var tempo = 400/60;
var time=0.2;
Pbind(
	/*
	3.1 after 3 means one
	chromatic step above 3,
	in this case F# above F
	*/
	\degree, Pseq([0, 1, 2, Rest(time), 3, 3.1, 4], 1),
	\dur, 1,
).play(TempoClock(tempo));
)
