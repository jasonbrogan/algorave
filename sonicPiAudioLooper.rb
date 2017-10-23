# modified from http://www.enhgo.com/snippet/ruby/sonic-pi-live-looper-proof-of-conceptrb_mbutz_ruby

use_bpm 120

# 8-beat loop to synchronize live_loops and
# to know, when recording will start which is:
# after every completed 8-beats, see :drums for
# knowing, when 8 beats are over ...
live_loop :metro do
  sleep 8
end

# uncomment if you want to record incoming sound
# if uncommented it will start recording any time you evaluate
uncomment do
  in_thread sync: :metro do
    with_fx :record, buffer: buffer[:recording, 8] do
      live_audio :testing
    end
  end
end

##| replay recorded 8-beat-phrase
live_loop :replay, sync: :metro do
  sample buffer[:recording], amp: 1.5
  sleep 8
end
