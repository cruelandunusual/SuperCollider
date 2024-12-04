s.plotTree;

~result = 4.squared;
squared(4);
~result.cubed-96.postln;

~result.postln;

{SinOsc.ar()}.play;

{SinOscFB.ar()}.play;

SinOsc.browse;

4.class;
"Text".class;
4.0.class;

4.0 * 3.0;

SinOsc.class;

(
x = {
	var a;
	a = FSinOsc.ar(880);
	//[a.neg, a.reciprocal ]
}
)


y = x.play;

y.free;



10.rand; //generates a random number between 0 and 9

{SinOsc.ar(440).sum3rand}.plot;


5.coin;

{SinOsc.ar(110).coin}.plot;

1 + 1.0.asBinaryArchive;


345.asBinaryDigits;

Integer.browse;
Float.browse;
Float.class;

345.neg();
neg(345);

2**3;
2.cubed();

3.round(2);

2.pow(3);

Boolean.class;

0.3.coin;

x = 3;
y = 4;
x;
y = x.dup(3);
x;
y;

1 + (4 + 2).pow(3);
10.do({"test".postln});

20.do({0.5.coin.postln});

10.do({[1, 2, 3].choose.postln});

//if(x == y)


35.isInteger;

(

var num;
num.isNil.postln;
num = 2;
num.isNil.postln;

)


(
~list = [2, 3, 4];
~list[0];
)

