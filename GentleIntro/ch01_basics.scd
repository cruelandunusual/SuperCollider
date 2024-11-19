/*
Contains code snippets from the book
A Gentle Introduction to SuperCollider,
as well as my own modifications as I try
to compose more complex versions of the book samples
*/

s.plotTree; // evaluate to generate a gui represention of objects on the server

// page 5
// a basic sine tone
{SinOsc.ar}.play;


// page 5
// I added the code to store this synth in x, and play it with y
(
x = {
	SinOsc.ar(LFNoise0.kr([10].choose).range(100,1500), mul: 0.1)
};
)
y = x.play;
y.free;


// page 7
(
a = {
	RLPF.ar(Dust.ar([12, 15]), LFNoise1.ar([0.3, 0.2]).range(100, 3000), 0.02)
}.play;
)


// generate a random number between the parameters passed
rrand(10,20);

// array notation
b = [0, 1, 2, 3, 4].scramble;
b[2];

// messing with Pbinds. I don't know what's going on here,
// seems Pbinds are quite different from SynthDefs.
// setting var 'a' equal to Pbind and evaluating a.play
// doesn't work. Pbinds are EvenStreamPlayers, whatever that is.
c = Pbind('note', Pwhite(0, 10), \dur, 0.1);
c.play;

Pbind(\note, [1,5,8], \dur, 0.9).play;