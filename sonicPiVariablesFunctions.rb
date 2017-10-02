# VARIABLES & FUNCTIONS

# in the following example, bassLine is a variable

##| bassLine = "/Users/jasonbrogan/Desktop/waitingBassline2.wav"

##| loop do
##|   slice_idx = rand_i(2)
##|   slice_size = 0.5
##|   s = slice_idx * slice_size
##|   f = s + slice_size
##|   sample bassLine, start: s, finish: f
##|   sleep slice_size
##| end

# in the following example, fMajor and dMinor are functions

##| define :fMajor do
##|   use_synth :blade
##|   play choose([:f4, :as4, :c4]), attack: 0.25, release: 0.25, amp: rrand(0.25, 1)
##|   sleep rrand(0.5, 1)
##| end

##| define :dMinor do
##|   use_synth :blade
##|   play choose([:d4, :f4, :a4]), attack: 0.25, release: 0.25, amp: rrand(0.25, 1)
##|   sleep rrand(0.5, 1)
##| end

##| live_loop :mainMelody do
##|   dMinor
##| end


##| with_fx :reverb do
##|   loop do
##|     if one_in(4)
##|       8.times do
##|         dMinor
##|       end
##|     else
##|       8.times do
##|         fMajor
##|       end
##|     end
##|   end
##| end
