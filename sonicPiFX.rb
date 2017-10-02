# FX

##| with_fx :reverb do
##|   use_synth :fm
##|   play 50, release: 0.25
##|   sleep 0.5
##|   sample :elec_plip
##|   sleep 0.5
##|   play 62, release: 0.25
##| end

# FX in practice

##| loop do
##|   sample :loop_amen, beat_stretch: 1.5
##|   sleep 1.5
##| end

##| loop do
##|   with_fx :reverb do
##|     sample :loop_amen, beat_stretch: 1.5
##|     sleep 1.5
##|   end
##| end

##| loop do
##|   with_fx :reverb do
##|     with_fx :compressor do
##|       with_fx :lpf, cutoff: 100 do
##|         sample :loop_amen, beat_stretch: 1.5
##|         sleep 1.5
##|       end
##|     end
##|   end
##| end

# the above example creates a new reverb effect every time it loops
# below is more efficient; we put our amen drum loop inside the fx block
# this creates a single reverb effect for our loop

##| with_fx :reverb do
##|   loop do
##|     sample :loop_amen, beat_stretch: 1.5
##|     sleep 1.5
##|   end
##| end