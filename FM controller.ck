//keyboard stuff :p
Hid hi;
HidMsg msg;

0 => int device;

hi.openKeyboard(device);

//Sound stuff
SinOsc c => dac;
SinOsc m => blackhole;
1.0 => c.gain;
1.0 => m.gain;

//FM mod params
me.arg(0) => Std.atoi => float cf; //carrier freq
600 => float mf => m.freq; //modulation frequency
100 => float index; //modulation index

//time to do the thing that I made this thing to do
while(true)
{
  
  //modulate sound
  cf + (index * m.last()) => c.freq;
  
  //check for inputs
    while(hi.recv(msg) && msg.isButtonDown())
    {
        if((msg.which == 208) && index > 5)
        {
            index - 10 => index;
            <<<"index: ", index>>>;
        } else if(msg.which == 200)
        {
            index + 10 => index;
            <<<"index: ", index>>>;
        } else if(msg.which == 203)
        {
            mf / 1.05 => mf;
            mf => m.freq;
            <<<"mod. freq: ", mf>>>;
        } else if(msg.which == 205)
        {
            mf * 1.05 => mf;
            mf => m.freq;
            <<<"mod. freq: ", mf>>>;
        } 
 
    }
        
  //advance time             
  1::samp => now;
    
}
