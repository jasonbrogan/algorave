##| sample :ambi_piano

##| AMP
##| sample :ambi_piano, amp: 0.5

##| PAN
##| sample :ambi_piano, pan: -1

##| PLAYBACK RATE
##| sample :ambi_piano, rate: 0.5
##| The sample not only takes twice as long to play, but it sounds an octave lower.

##| sample :loop_compus
##| ...the same as:
##| sample :loop_compus, rate: 1

##| HALF-SPEED
##| sample :loop_compus, rate: 0.5
##| sample :loop_compus, rate: 1.5
##| sample :loop_compus, rate: -1

##| samples as springs

##| SAMPLE ENVELOPES
##| This is used to modify the amplitude and duration of a sample.
##| You can reduce the amplitude and duration of a sample, but not increase it.

##| Fade in for 1 beat
##| sample :loop_compus, attack: 1
##| Fade in for 1/2 beat
##| sample :loop_compus, attack: 0.5

##| Sustain is set to the length of the sample.
##| Sonic Pi calculates the sample duration, deducts any attack, decay, and release times,
##| and the result is the sustain time.

##| Print the sample duration
##| print sample_duration :loop_compus

##| Fade out
##| sample :loop_compus, attack: 2, release: 3
##| Because is the sample duration is about 6.5 seconds,
##| it will sustain at max. amplitude for about [...] seconds.

##| The following is akin to using an ADSR envelop on a synth.
##| sample :loop_compus, sustain: 0, release: 3

##| sample :drum_cymbal_open
##| Make it shorter!
##| sample :drum_cymbal_open, attack: 0.01, sustain: 0, release: 0.1
##| The following is akin to hitting the cymbal and then dampening it.
##| sample :drum_cymbal_open, attack: 0.01, sustain: 0.25, release: 0.1

##| START AND STOP POINTS
##| 0 = beginning of the sample
##| 1 = end of the sample
##| sample :loop_amen
##| sample :loop_amen, start: 0.4, finish: 0.6
##| sample :loop_amen, start: 0.6, finish: 0.4
##| COMBINE WITH RATE
##| sample :loop_amen, start: 0.5, finish: 0.7, rate: 0.2
##| USE AN ENVELOPE TO SHAPE AMPLITUDE
##| sample :loop_amen, start: 0.5, finish: 0.8, rate: -0.2, attack: 0.3, release: 1

##| live_loop :compus do
##|   sample :loop_amen, amp: 0.5
##|   sleep sample_duration :loop_amen
##| end