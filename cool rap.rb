# Welcome to Sonic Pi v2.10
use_bpm 120
# Arpeggiated melody
live_loop :melody do
  use_synth :dark_ambience
  play chord(:D4, :M7).tick
  sleep 0.25
end

# Chords - uses a simple four chord progression.
live_loop :chords do
  use_synth :hoover
  play chord(:D2, :major), amp: 0.5
  sleep 1
  play chord(:A2, :major), amp: 0.5
  sleep 1
  play chord(:B2, :minor), amp: 0.5
  sleep 1
  play chord(:G2, :major), amp: 0.5
  sleep 1
end


# Kicks

def kick(v)
  
  sample :bd_mehackit, amp: 2*v
  
end


# The regular kick

live_loop :kick1 do
  
  kick(1)
  
  sleep 5
  
  kick(1)
  
  sleep 3
  
end


#the irregular "bounce" kick

live_loop :kick2 do
  
  v=[0,0,0,0,0.7,0.9].choose
  
  kick(v)
  
  sleep 7
  
end


# The 808 / bass

def _808(p,v,d)
  
  play p-24, amp: v, attack: 0.3, decay: d, sustain: 0, release: 0.5
  
end


with_fx :slicer do |sl|
  
  live_loop :_808 do
    
    control sl, phase: [6,6,6,6,6,4,4,2,1,0.5].choose
    
    _808(chord(:E3, :major)[0],1,3.5)
    
    sleep 5
    
    _808(chord(:E3, :major)[0],1,1.6)
    
    sleep 3
    
  end
  
end


# snares ...

# why doesn't sonic pi come with better snare sounds?

def snare(v)
  
  sample :sn_generic, rate: 2, amp: 3*v, attack: 0, sustain: 0, release: 0, decay: 0.06
  
  sample :drum_snare_hard, rate: 2, amp: 1.5*v, attack: 0.01, sustain: 0, release: 0, decay: 0.03
  
end


with_fx :distortion do
  
  live_loop :snare do
    
    vs = [0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,1]
    
    vs.each {
      
      |v|
      
      snare(v)
      
      sleep 1
      
    }
    
  end
  
end


# Those all important hats

def hat(v)
  
  sample :drum_cymbal_closed, amp: 1.5*v, attack: 0, decay: 0.01, sustain: 0, release: 0
  
end


live_loop :hats do
  
  a = [0,0,0,1,1,2,2,2,2].choose
  
  case a
  
  when 0
    
    8.times do
      
      hat(1)
      
      sleep 0.5
      
    end
    
  when 1
    
    8.times do
      
      hat(1)
      
      sleep 0.25
      
    end
    
  when 2
    
    2.times do
      
      hat(1)
      
      sleep 0.3
      
      hat(1)
      
      sleep 0.3
      
      hat(1)
      
      sleep 0.4
      
    end
    
  end
  
end


