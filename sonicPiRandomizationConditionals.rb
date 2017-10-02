# RANDOMIZATION & CONDITIONALS

##| loop do
##|   sample :perc_bell, rate: 1
##|   sleep 1
##| end

# Because we're making music with algorithms,
# we can program patterns/sounds/melodies/beats that evolve over time.
# Let's add some randomization.
# Note how altering the playback rate changes the sample pitch.

##| loop do
##|   sample :perc_bell, rate: (rrand 0.5, 1)
##|   sleep rrand(0.2, 1)
##| end

# Let's apply randomization to the pitch and cutoff paramaters of the TB-303 synth

##| use_synth :tb303

##| loop do
##|   play rrand(50, 60), release: 0.1, cutoff: rrand(60, 120)
##|   sleep 0.125
##| end

##| use_synth :tb303

##| loop do
##|   play rrand(50, 53), release: 0.1, cutoff: rrand(60, 120)
##|   sleep 0.125
##| end


# TYPES OF RANDOMIZATION

# choose
# chooses an item randomly from a list of known items

##| use_synth :tb303

##| loop do
##|   play choose([:f4, :fs4, :g4]), release: 0.1, cutoff: 100
##|   sleep 0.125
##| end

##| use_synth :hollow
##| with_fx :reverb, mix: 0.7 do

##|   live_loop :note1 do
##|     play choose([:D4,:E4]), attack: 6, release: 6
##|     sleep 8
##|   end

##|   live_loop :note2 do
##|     play choose([:Fs4,:G4]), attack: 4, release: 5
##|     sleep 10
##|   end

##|   live_loop :note3 do
##|     play choose([:A4, :Cs5]), attack: 5, release: 5
##|     sleep 11
##|   end

##| end

# rrand
# returns a random number—a float—between two values exclusively
# i.e., it will never return the top or bottom value

##| use_synth :tb303

##| loop do
##|   play choose([50, 55, 62]), release: 0.1, cutoff: rrand(60, 120)
##|   sleep 0.125
##| end

# rrand_i
# returns a random integer, i.e., NOT a float
# inclusive of its range, so it may return the top or bottom value

##| use_synth :tb303

##| loop do
##|   play rrand_i(50, 62), release: 0.1, cutoff: rrand(60, 120)
##|   sleep 0.125
##| end

##| loop do
##|   sample :loop_amen, beat_stretch: 1.5, rate: rrand_i(-1, 1)
##|   sleep 1.5
##| end

# Why the above example NOT work with rate: rrand_i(-1, 1)?

# rand

# returns a float between 0 (inclusive) and the specified max value (exclusive)
# by default, its min value is 0, and its max value is 1
# so it's useful for modifying the value of amplitude!

##| use_synth :tb303

##| loop do
##|   play rrand_i(50, 62), release: 0.1, cutoff: rrand(60, 120), amp: rand
##|   sleep 0.125
##| end

# rand_i

# similarly to rand, this returns a random INTEGER between 0 (inclusive) and a max (exclusive)
# you may specify the max value [the default is 1]

##| loop do
##|   print rand_i(3)
##|   sleep 0.125
##| end

# dice
# this emulates a dice throw
# a special case of rrand_i where the lower value is ALWAYS 1
# a call to dice requires you to specify the number of sides on the dice
# returns a value between 1 and the number of sides (inclusively)

##| loop do
##|   print dice(6)
##|   sleep 1
##| end

##| in_thread(name: :bdWood) do
##|   loop do
##|     sample :bd_fat
##|     sleep 0.5
##|   end
##| end

##| loop do
##|   sample :elec_wood, release: 0.5, amp: 0.5 if dice(2) == 2
##|   sleep 0.5
##| end

##| with_fx :lpf, cutoff: 90 do
##|   live_loop :randomSnap do
##|     sample :perc_snap if dice(3) == 2
##|     sleep 0.125
##|   end
##| end

##| live_loop :kickDrum do
##|   sync :randomSnap
##|   sample :bd_tek
##|   sleep 1
##| end

# one_in
# returns a value based on probability
# e.g., a 1 in [x] chance of playing a drum sound
# the lower the number, the greater the chance of its sounding

##| live_loop :differentProbabilities do
##|   sample :elec_fuzz_tom if one_in(16)
##|   sleep 0.125
##| end

##| live_loop :multi_beat do
##|   sample :elec_hi_snare if one_in(8)
##|   sample :drum_cymbal_closed if one_in(2)
##|   sample :bd_haus
##|   sleep 0.125
##| end

# Let's use use_random_seed to RESET the stream
# after it has played eight times

##| live_loop :multi_beat do
##|   use_random_seed 450
##|   # use random seeds: 23, 450, 890, etc.
##|   8.times do
##|     sample :elec_hi_snare if one_in(6)
##|     sample :drum_cymbal_closed if one_in(2)
##|     sample :bd_haus if one_in(4)
##|     sleep 0.125
##|   end
##| end

# remember which seeds sound good and make a note of them;
# that way you can easily re-create the rhythms in future practice sessions or performances

# conditionals

# flipping a coin
# if it's heads, play a C
# if it's tails, play an E

##| use_synth :hoover

##| loop do

##|   if one_in(2)
##|     play :c4
##|   else
##|     play :e4
##|   end

##|   sleep 1
##| end

##| use_synth :hoover

##| loop do

##|   if one_in(4)
##|     play :c4
##|     sleep 1
##|   else
##|     play :e4
##|     sleep rrand_i(1, 2)
##|   end

##| end

# use conditional statements to execute just one line of code

##| use_synth :pluck
##| with_fx :reverb, room: 1 do
##|   loop do
##|     play 50, amp: 0.3, release: 3
##|     play 53, amp: 0.3, release: 3 if one_in(2)
##|     play 57, amp: 0.3, release: 3 if one_in(2)
##|     play 60, amp: 0.3, release: 3 if one_in(2)
##|     sleep choose([1, 1.5, 2])
##|   end
##| end