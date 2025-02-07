4.squared;

~num = 4;
postln(squared(~num));
postln(~num);


f = {
	SinOsc.ar(freq:440, mul:0.2)
}.play;

g = f.play;
f.free;

f = {
	|x = 2,y = 3|
	//x = y = 3;
	postln(4);
	y = x;
	y;
}

f.value;
