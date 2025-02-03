ServerOptions.devices;

Server.default.options.device = "Windows DirectSound";
Server.default.options.device = "ASIO : ASIO4ALL v2";
Server.default.options.device = "ASIO : Generic Low Latency ASIO Driver";

x = {SinOsc.ar(880.0, 9.0, 1.0, 1.0)};

y = x.play;

y.free;

s.boot;

m = 10;
b = { Blip.ar(Blip.kr(4*m, 5*m, 500*m, 60*m).poll(), 59, 0.2) ! 2};

c = b.play;
c.free;



x = {SinOsc.ar(600) * 0.25}.play;
x.free;


