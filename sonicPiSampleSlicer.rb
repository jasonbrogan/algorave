# Sample Slicer

# This slices the Amen loop sample into 8 slices of equal length and randomly plays through them

live_loop :sample_slicer do
  slice = rand_i(8)
  slice_size = 0.125
  s = slice * slice_size
  f = s + slice_size
  sample :loop_amen, start: s, finish: f
  sleep sample_duration :loop_amen, start: s, finish: f
end

# Another approach

a = [file path of your sample]

live_loop :sample_slicer do
  slice = rand_i(8)
  slice_size = 0.125
  s = slice * slice_size
  f = s + slice_size
  n = [1, 2, 3, 4].choose
  sample a, beat_stretch: 32, start: s, finish: f
  sleep n
end
