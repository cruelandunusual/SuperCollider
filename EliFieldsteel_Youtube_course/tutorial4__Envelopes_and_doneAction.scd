Server.local.plotTree;
s.plotTree;
s.volume.gui;


// a recap that to free a synth it needs to be stored in a variable
// representing the playing synth, not the synth definition
x = {SinOsc.ar(440)};
y = x.play;
y.free;


// creating a fairly complicated synth
// with XLine as an envelope
(
{
	//doneAction:2 frees the synth from the server when it's finished
	var pulseSig, pulseFreq, sineSig, sineFreq, triSig, triFreq,
	envDuration, sigDuration, envelope, output;

	envDuration = 4;//Rand(2);
	sigDuration = 4;//Rand(0.1, 4);

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


5.ampdb; //convert amplitude to decibels
5.dbamp; //convert decibels to amplitude


/*
---------------------------------------------------------------
*/

// create a new envelope stored in m
// the first array is an array of levels
// the second array is durations between those levels
// the third parameter is a symbol for the curvature between the levels
// it can also be an float or an array of either symbols or floats
m = Env.new([0, 0.6, 0.2, 0.7, 0], [1, 0.4, 0.2, 0.8], curve: \sine);//.plot;


// use that envelope in a basic synth
{SinOsc.ar(440.0, 0.0, EnvGen.kr(m, doneAction: Done.freeSelf), 0.0)}.play;
//{SinOsc.ar(440.0, 0.0, EnvGen.kr(Env.linen, doneAction: Done.freeSelf), 0.0)}.play; //timeScale: 0.09,


// here's the synth from earlier in this document with an EnvGen as the envelope for the pulse UGen
// note I'm still multiplying this UGen by the envelope variable -- here it only seems to affect amplitude
(
{
	//doneAction:2 frees the synth from the server when it's finished
	var pulseSig, pulseFreq, sineSig, sineFreq, triSig, triFreq,
	envDuration, sigDuration, envelope, output;

	envDuration = 4;//Rand(2);
	sigDuration = 4;//Rand(0.1, 4);

	envelope = XLine.kr(1, 0.01, envDuration, doneAction:2);

	pulseFreq = XLine.kr(880, 220, sigDuration, doneAction: 2);
	pulseSig = Pulse.ar(pulseFreq, EnvGen.kr(Env.linen, doneAction: Done.freeSelf)) * envelope;

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


// here I just pulled out the pulse UGen from the above synth to have something simpler to play with
(
{
	var pulseFreq, pulseSig, sigDuration;
	sigDuration = 9;
	pulseFreq = XLine.kr(880, 220, sigDuration, doneAction: 2);
	pulseSig = Pulse.ar(pulseFreq, EnvGen.kr(Env.perc, doneAction: Done.freeSelf));// * envelope;

}.play;
)

// plotting the env shapes
Env.perc.plot;



/*
Nominally here in this video:
https://youtu.be/-wDAPo9hpCg?si=jmHWWQSFEHFZVgNF&t=584
But I've been messing around with changing things outside of the video
*/



