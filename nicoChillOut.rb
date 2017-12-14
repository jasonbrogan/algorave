arp = (ring :B2, :C3, :E3, :G3, :C4, :G3, :E3, :C3)
arp2 = (ring :B2, :C3, :E3, :G3, :B3, :G3, :E3, :C3)
arp3 = (ring :C3, :C3, :G3, :G3, :C4, :G3, :E3, :C3)
arpamp = 0.5
arpsleep = 0.6

with_fx :reverb, mix:1 do
 live_loop :arp do
   8.times do
     if one_in(3)
       use_synth :hoover
       play arp.tick, attack: 0.2, sustain: 1, amp: arpamp/2
       sleep arpsleep
     else
       
       if one_in(2)
         use_synth :piano
         play arp2.tick, sustain: 1, amp: arpamp
         sleep arpsleep
       else
         use_synth :tri
         play arp3.tick, sustain: 1, amp: arpamp
         sleep arpsleep
       end
     end
     
   end
 end
end

amenamp = 1
live_loop :amen do
 sample :ambi_glass_hum, pitch: choose([3, 7, 8, 10]), amp: amenamp
 sleep sample_duration(:ambi_glass_hum)
end

bg1amp = 1
bg1stretch = 1
with_fx :reverb, mix: 1 do
 live_loop :bg1 do
   use_synth :dark_ambience
   play choose([:C3, :B2, :D2]), amp: bg1amp, attack: 4, attack_level: 0.7, release: 4, beat_stretch: bg1stretch*16
   sleep bg1stretch*16
 end
end

newpitch = ([-5, -5,-6, -6, -8, -8, -10, -10])
choramp = 3
chorsleep = 0.6
with_fx :echo, decay: 1 do
 live_loop :chor do
   sample :ambi_choir, pitch: newpitch.ring.tick, attack: rrand(1, 3), sustain: 4, release: 4, beat_stretch: arpsleep * 8, amp: choramp
   sleep arpsleep * 10
 end
end


##| arp = (ring :B2, :C3, :E3, :G3, :C4, :G3, :E3, :C3)
##| arp2 = (ring :B2, :C3, :E3, :G3, :B3, :G3, :E3, :C3)
##| arp3 = (ring :C3, :C3, :G3, :G3, :C4, :G3, :E3, :C3)
##| SmallDur = 0.25
##| BigDur = 4

##| with_fx :compressor do
##|   live_loop :elody do
##|     sync "/live_loop/sync"
##|     use_synth :pretty_bell
##|     if one_in (3)
##|       play arp.tick, sustain: 0.1, amp: 0.25
##|     else
##|       if one_in (2)
##|         play arp3.tick, sustain: 0.1, amp: 0.25
##|       else
##|         play arp2.tick, sustain: 0.1, amp: 0.25
##|       end

##|     end
##|     sleep 0.25
##|   end
##| end






##| live_loop :highpitch do
##|   use_synth :hoover
##|   if one_in (10)
##|     play :C7, amp: 0.5, attack: 0.2, release: 0.2
##|     sleep SmallDur
##|     play :C6, amp: 0.5, attack: 0.2, release: 0.2
##|     sleep SmallDur
##|     play :E6, amp: 0.5, attack: 0.2, release: 0.2
##|     sleep (BigDur - SmallDur*3)
##|     play :G5, amp: 0.5, attack: 0.2, release: 0.2
##|     sleep SmallDur
##|   end
##| end

