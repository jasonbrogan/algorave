# INS & OUTS, PART 1

# mono audio input

# Example 1

##| with_fx :reverb, room: 0.9 do
##|   with_fx :bitcrusher, bits: 8 do
##|     live_audio :sax
##|   end
##| end

# Example 2 (with MIDI control)

##| use_real_time
##| chan, val = get "/midi/launch_control/0/9/control_change"
##| if chan == 21 then
##|   revMix = val.to_f/127
##| end
##| if chan == 22 then
##|   echoMix = val.to_f/127
##| end
##| if chan == 23 then
##|   lpfCutoff = val
##| end
##| if chan == 24 then
##|   pitchShiftMix = val.to_f/127
##| end
##| with_fx :reverb, room: 0.8, mix: revMix do
##|   with_fx :echo, phase: 0.25, decay: 2, mix: echoMix do
##|     with_fx :lpf, cutoff: lpfCutoff, mix: 1 do
##|       with_fx :pitch_shift, pitch: 0, mix: pitchShiftMix do
##|         live_audio :sax
##|       end
##|     end
##|   end
##| end

# stereo input

##| with_fx :reverb do
##|   live_audio :stereoMix, stereo: true, input 2
##| end


# MIDI

# MIDI (Musical Instrument Digital Interface) is a communications protocol.
# It carries both event messages, e.g., note trigger,
# and contol (change) signals for parameters like tempo/bpm.
# It requires MIDI cable/connectivity.

# MIDI in

##| live_loop :bassLine do
##|   use_real_time
##|   chan, val = get "/midi/launch_control/0/9/control_change"
##|   if chan == 21 then
##|     ampVal = val.to_f/127
##|   end
##|   if chan == 22 then
##|     co = val
##|   end
##|   if chan == 23 then
##|     revMix = val.to_f/127
##|   end
##|   with_fx :reverb, damp: 1, room: 1, mix: revMix do
##|     use_synth :tb303
##|     play (knit :c2, 2, :d2, 2, :c2, 2, [:eb2, :g2].choose, 2).tick, release: 0.25, cutoff: co, amp: ampVal
##|     sleep 0.25
##|   end
##| end

# MIDI out

##| use_bpm 85

##| arp = (ring :c3, :e3, :g3, :b3, :c4, :b3, :g3, :e3)

##| live_loop :kick do
##|   sample :bd_haus, cutoff: 60
##|   sleep 0.25
##|   sample :bd_haus, cutoff: 60
##|   sleep 0.75
##| end

##| live_loop :strangerThingsTheme do
##|   use_real_time
##|   midi arp.tick, sustain: 0.1
##|   sleep 0.25
##| end

# OSC in

# OSC (Open Sound Control) is another communications protocol.
# Unlike MIDI, it's useful for networking technology.
# OSC messages may be sent from one program, e.g., Processing, to another, e.g., Sonic Pi.

# Run the live_loop code before starting the Processing program.

# USE WITH PROCESSING FILE: sonicPiProcessingOSC.pde

##| puts nv #uncomment and comment next line to see OSC input
##| scale the mX and mY values in nv[0] and nv[1] appropriately
##| raw mX 124(left)-516(right) and raw mY 124 (top)-236(bottom

##| use_synth :tb303
##| live_loop :os do
##|   nv = get "/osc/notesend"
##|   puts (40+(nv[0]-124)/392*60).to_i.to_s+" "+(190-nv[1]/2).to_s
##|   play (40+(nv[0]-124)/392*60).to_i,cutoff: (190-nv[1]/2),sustain: 0.04,release: 0.01
##|   sleep 0.5
##| end
