4.squared;

"string".choose;

~num = 4;
postln(squared(~num));
postln(~num);


f = {
	SinOsc.ar(freq:440, mul:0.2)
}.play;

g = f;

f.free;

f = {
	|x = 2,y = 3|
	//x = y = 3;
	postln(4);
	y = x;
	y;
}

f.value;


[1, 2, 3, 4].dup(2).choose.dup(2);

(
~myfunction = {
	arg input = 4;
	var num;
	num = input.squared;
	num = input.reciprocal;
};
)
~myfunction.(5);


/* RANDOMNESS */

rand(4);

rand(4,3);

rrand(2, 5);

rrand(30.0, 100.0);

exprand(1, 100);

[3,7].normalizeSum.choose.coin.postln;
//.choose;

{exprand(1,12)}.dup(2);

{coin(0.5)}.dup(2);

(
var scale, note;
scale = [330, 440, 54, 495, 886, 8584];
note = scale.choose;
)


(
var bag, choice;
bag = [\red, \green, \blue];
choice = bag.wchoose([750, 220, 30].normalizeSum);
)