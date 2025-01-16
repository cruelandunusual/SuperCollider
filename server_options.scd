ServerOptions.devices; // evaluate this for a list of audio device options

Server.default.options.device = "Windows DirectSound";
Server.default.options.device = "ASIO : ASIO4ALL v2"; // use this for no conflicts with browser
Server.default.options.device = "ASIO : Generic Low Latency ASIO Driver";

s.boot;
s.quit;
Server.killAll;

ScIDE.send(\requestDocumentList); // use this if getting the Text Mirror error message...

// Use this to calibrate hardware volume levels
{PinkNoise.ar(mul:1) ! 2}.play;