s.boot;
s.quit;
s.plotTree;
s.sampleRate;
s.options.blockSize;


( // add Oscillator signals together (I saw this in a later chapter of the
 //book but wanted to try it here to see if I could remember the main idea
x = {
	var sig;
	sig = SinOsc.ar;
	sig = sig + Blip.ar;

}
)
y = x.play;
y.free;


