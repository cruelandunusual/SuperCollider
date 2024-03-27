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
var tempo = 120/60;
Pbind(
	/*
	3.1 after 3 means one
	chromatic step above 3,
	in this case F# above F
	*/
	\degree, Pseq([0, 1, 2, 3, 3.1, 4], 1),
	\dur, 0.2;
).play(TempoClock(tempo));
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
var tempo = 120/60;
var time = 0.2;
var beat = 1;
Pbind(
	/*
	3.1 after 3 means one
	chromatic step above 3,
	in this case F# above F
	*/
	\degree, Pseq([0, 1, 2, Rest(beat), 3, 3.1, 4], 1),
	\dur, beat,
).play(TempoClock(tempo));
)

/*
 * Tue 26-03-2024
 * (Re)Learning about patterns
 *
 */
(
Pbind(
	\freq, Pn(Pseries(110, 110, 10)),
	\dur, 1/2,
	\legato, Pwhite(0.1, 1);
).play;

Pbind(
	\freq, Pn(Pseries(220, 222, 10)),
	\dur, 1/4,
	\legato, Pwhite(0.1, 1);
).play;

Pbind(
	\freq, Pn(Pseries(330, 333, 10)),
	\dur, 1/6,
	\legato, 0.1;
).play;
)

(//using {}.fork to evaluate code in a timed manner
{
	"one thing".postln;
	2.wait;
	"another thing".postln;
	1.5.wait;
	"one last thing".postln;
}.fork;
)

(//using {}.fork to play a proper tune that actually sounds good
var t = TempoClock(76/60);
~t = TempoClock(76/60); //~name is the same as var name
{
	Pbind(
		\note, Pseq([[4, 11], [6, 9]], 32),
		\dur, 1/6,
		\amp, Pseq([0.05, 0.03], inf);
	).play(~t);

	2.wait;

	Pbind(
		\note, Pseq([[-25, -13, -1], [-20, -8, 4], \rest], 3),
		\dur, Pseq([1, 1, Rest(1)], inf),
		\amp, 0.1,
		\legato, Pseq([0.4, 0.7, \rest], inf)
	).play(t);

	2.75.wait;

	Pbind(
		\note, Pseq([23, 21, 25, 23, 21, 20, 18, 16, 20, 21, 23, 21], inf),
		\dur, Pseq([0.25, 0.75, 0.25, 1.75, 0.125, 0.125, 0.80, 0.20, 0.125, 0.125, 1], 1),
		\amp, 0.1,
		\legato, 0.5
	).play(t);

}.fork(t);
)

/*
 * Wed 27-03-2024
 * (Re)Learning about patterns
 *
 */
(
~scale = [0, 1, 2, 3, 4, 5, 6, 7];
~durs = [0.4, 0.2, 0.2, 0.4, 0.8, 0.2, 0.2, 0.2];

Pbind(
\degree, Pseq(~scale),
\dur, Pseq(~durs)
).play;

Pbind(
\degree, Pseq(~scale.reverse + 7), //reversed and an octave higher
\dur, Pseq(~durs)
).play;
)

//define a score
(
~scale = [0, 1, 2, 3, 4, 5, 6, 7];
p = Pbind(
	\degree, Pseq(~scale, inf),
	\dur, 1/2
); // the whole Pbind stored in p is, in effect, the score
)
//now we create a variable, q, and store the EventStreamPlayer in it
q = p.play;
q.stop; // that way we can start it and stop it, without having to do [ctrl+.], which kills everything
q.resume;
q.stop.reset;
q.start;
q.stop;


/* ------------- */

// Define the score
(
var myDurs = Pseq([Pn(1, 5), 3, Pn(1, 5), 3, Pn(1, 6), 1/2, 1/2, 1, 1, 3, 1, 3], inf) * 0.4;

~upperMelody = Pbind(
	\midinote, Pseq([69, 74, 76, 77, 79, 81, Pseq([81, 79, 81, 82, 79, 81], 2), 82, 81, 79, 77, 76, 74, 74], inf), //nested Pseq...
	\dur, myDurs
);

~lowerMelody = Pbind(
	\midinote, Pseq([57, 62, 61, 60, 59, 58, 57, 55, 53, 52, 50, 49, 50, 52, 50, 55, 53, 52, 53, 55, 57, 58, 61, 62, 62], inf),
	\dur, myDurs
);
)
// Play the two together:
(
~player1 = ~upperMelody.play;
~player2 = ~lowerMelody.play;
)
// Stop them separately:
~player1.stop;
~player2.stop;

// Stop them together
(
~player1.stop;
~player2.stop;
)
// Other available messages
~player1.resume;
~player1.reset;
~player1.play;
~player1.start; // same as .play

/* --------------- */

(
//~scale = [0, 1, 2, 3, 4, 5, 6, 7];
~scale = [-1, 4, 7,];

p = Pbind(
	\degree, Pseq([3, 4, 5, ~scale, 2, 1, 0], inf), // the nested sequence gets played as a chord
	\dur, 0.5
);
)
~player = p.play;
~player.stop;