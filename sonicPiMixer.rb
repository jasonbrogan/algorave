use_debug false

# METRONOME

live_loop :metro do
  sleep 1
end

# MIXER

# START / STOP LOOPS
# 1 starts loop; 0 stops loop

drums = 0
drumLoop = 0
asyncLoop = 0
bass = 0
melody1 = 0
melody2 = 0

# ADJUST LOOP LEVELS

bdLevel = 0.9
snLevel = 0.9
drumLoopLevel = 0.85
asyncLoopLevel = 0.65
bassLevel = 0.9
melody1Level = 0.9
melody2Level = 0.9

# LOOPS

# Drums

with_fx :reverb do
  live_loop :drums, sync: :metro do
    stop if drums < 1
    sample :bd_fat, amp: bdLevel
    sleep 1
    with_fx :echo, mix: 0.125, phase: 0.125 do
      sample :sn_dub, amp: snLevel
    end
    sleep 1
  end
end

# Drum Loop

with_fx :reverb, room: 0.75 do
  live_loop :drumLoop, sync: :metro do
    stop if drumLoop < 1
    with_fx :rlpf, cutoff: knit(90, 4, 100, 4).tick, res: 0.95, mix: 1 do |rlpf|
      control rlpf, res: 0.99
      sample :loop_compus, beat_stretch: 8, amp: drumLoopLevel
      sleep 8
    end
  end
end

# Asynchronous Loop

with_fx :hpf, cutoff: 90 do
  with_fx :compressor do
    live_loop :asyncLoop do
      stop if asyncLoop < 1
      sample :loop_tabla, beat_stretch: 6, amp: asyncLoopLevel
      sleep 6
    end
  end
end

# Bass
# Choose random note from a C2 minor chord [C2, Eb2, G2].

live_loop :bass, sync: :metro do
  stop if bass < 1
  use_synth :chipbass
  play chord(:c2, :minor).choose, sustain: 2, amp: bassLevel
  sleep 4
end

# Melody 1
# arpeggiate across a three-octave C minor pentatonic scale [C, Eb, F, G, Bb]

with_fx :reverb, room: 0.8 do
  live_loop :melody1, sync: :metro do
    stop if melody1 < 1
    use_synth :dsaw
    play (scale :c2, :minor_pentatonic, num_octaves: 3).tick, release: 0.25, amp: melody1Level, pan: -1
    sleep 0.25
  end
end


# Melody 2

with_fx :reverb, room: 0.8 do
  live_loop :melody2, sync: :metro do
    stop if melody2 < 1
    use_synth :dsaw
    play (knit :c4, 2, :d4, 2, :c4, 2, [:eb4, :g4].choose, 2).tick, release: 0.25, amp: melody2Level, pan: 1
    sleep 0.25
  end
end


