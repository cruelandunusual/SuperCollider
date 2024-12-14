ServerOptions.devices;

Server.default.options.device = "Windows DirectSound";
Server.default.options.device = "ASIO : ASIO4ALL v2"; // use this for no conflicts with browser
Server.default.options.device = "ASIO : Generic Low Latency ASIO Driver";

s.boot;
s.quit;


x = {SinOsc.ar(880.0, 9.0, 1.0, 1.0)};
y = x.play;
y.free;



m = 10;
b = { Blip.ar(Blip.kr(4*m, 5*m, 500*m, 60*m).poll(), 59, 0.1) };

c = b.play;
c.free;



x = {SinOsc.ar(600) * 0.25}.play;
x.free;


(
z = {
	arg freq=440, amp=1;
	var sig;
	sig = SinOsc.ar(freq) * amp;
}.play;
)
z.free;

z.set(\freq,660, \amp, 0.8);


(
z = {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(exprand(50,300),1000);
	amp = LFNoise0.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq) * amp;
}.play;
)
z.free;

z.set(\noiseHz, exprand(4, 16));


(
z = { //make a function with curly brackets
	arg noiseHz = 8; //declare args before vars
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(50,1000);
	amp = LFNoise0.kr(12).exprange(0.02,0.75);
	sig = SinOsc.ar(freq) * amp;
}.play;
)
z.free;



(
a = {//make a function with curly brackets
	arg noiseHz = 9;
	var freq, amp, signal;
	freq = SinOsc.kr(noiseHz).exprange(50,100);
	amp = SinOsc.kr(2);
	/*
	note the creation of an oscillator
	freq is the argument, multiply the result by amp
	*/
	signal = SinOsc.ar(freq) * amp;
}.play;
)
a.set(\noiseHz, 800);
a.free;




