x = {SinOsc.ar(440)};
y = x.play;

y.free;

Server.local.plotTree;
s.plotTree;


(
{
	//doneAction:2 frees the synth from the server when it's finished
	var pulseSig, pulseFreq, sineSig, sineFreq, triSig, triFreq,
	envDuration, sigDuration, envelope, output;

	envDuration = 2;//Rand(2);
	sigDuration = Rand(0.1, 2);

	envelope = XLine.kr(1, 0.01, envDuration, doneAction:2);

	pulseFreq = XLine.kr(880, 220, sigDuration, doneAction: 2);
	pulseSig = Pulse.ar(pulseFreq) * envelope;

	triFreq = XLine.kr(440, 220, sigDuration, doneAction:2);
	triSig = LFTri.ar(triFreq) * envelope;

	sineFreq = XLine.kr(660, 110, sigDuration, doneAction:2);
	sineSig = SinOsc.ar(sineFreq) * envelope;
	/*
	playing around with UGen arithmetic
	I'm not really sure what's going on here
	I *think* the waves are being combined
	*/
	output = pulseSig - sineSig + triSig;

}.play;
)

y = x.play;
y.free;

s.volume.gui;



5.ampdb; //convert amplitude to decibels
5.dbamp; //convert decibels to amplitude

/*
Nominally here in this video:
https://youtu.be/-wDAPo9hpCg?si=nEkxlPEzEFcxM05j&t=408
But I've been messing around with changing things outside of the video
*/