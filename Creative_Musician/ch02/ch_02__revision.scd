{Pulse.ar(freq:440, width:0.9, mul:0.2)!2}.play;
{Saw.ar(freq:440, mul:0.2)!2}.play;
{SinOsc.ar(freq:440, phase:2pi, mul:0.2)!2}.play;
{SinOsc.ar(freq:440, mul:0.2)!2}.play;

{LFTri.ar([400,600].choose, iphase:0, mul:0.2)!2}.play;


{[SinOsc.ar(freq:440, phase:0.0, mul:0.2), VarSaw.ar(freq:440, mul:0.2)]}.scope;
