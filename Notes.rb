# coding: iso-8859-1

Freq = ((ARGV.size() > 0) ? ARGV[0].to_f : 16000000.0) / 2.0
Div = [ 1.0, 8.0, 64.0, 256.0, 1024.0 ]


def calcDivCnt(c)
  Div.each_with_index do |d, di|
    return [d, di+1, c/d] if ((c / d) < 255)
  end
  return [0, 0, 0]
end

################################################################################
# Hoehe
################################################################################

Octav = %w{ C CIS D DIS E F FIS G GIS A AIS H }

class Note
  def initialize(name, freq)
    @name     = name
    @freq     = freq

    @div, @divIdx, @cnt = calcDivCnt(Freq / @freq)
  end

  attr_reader :name, :freq, :div, :divIdx, :cnt
end


noten = []

aHz = 440.0 # note a_2
delta = 2.0 ** (1.0/12.0)

freq = (aHz / delta ** 10.0) / 4.0 # deepest note c_0

(0..4).each do |octav|
  Octav.each do |tonName|
    name = "%s_%d" % [tonName, octav]
    freq *= delta
    noten << Note.new(name, freq)
  end
end

puts "pitch:"
noten.each_with_index { |n,i| puts ".byte 0x%02x, 0x%02x ; [%02x] %-5s %7.2f\n" % [ n.divIdx, n.cnt, i, n.name, n.freq ] }

################################################################################
# Laenge
################################################################################

T2Freq = (ARGV.size() > 1) ? ARGV[1].to_f : 8000.0

Duration = 3.0
Laengen = [ 1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0 ]

class Laenge
  def initialize(name, duration)
    @name     = name ;
    @duration = duration

    @on   , @off    = calcDuration(0.9, duration, 0.2     )
    @onDot, @offDot = calcDuration(0.2, 0.2     , duration)
    @onSlr, @offSlr = calcDuration(1.0, duration, duration)
  end

  private

  def calcDuration(onFrac, maxOn, maxOff)
    off = @duration * (1.0 - onFrac)
    off = maxOff if (off > maxOff)
    on  = @duration - off
    on  = maxOn if (on > maxOn)
    off = @duration - on
    [(on*T2Freq).to_i, (off*T2Freq).to_i]
  end

  public
  
  attr_reader :name, :duration,
              :on, :off, :onDot, :offDot, :onSlr, :offSlr
end

laengen = []


Laengen.each do |laenge|
  name = laenge.to_s
  laengen << Laenge.new(name, Duration / laenge.to_f)

  name = laenge.to_s + '.'
  laengen << Laenge.new(name, Duration * 1.5 / laenge.to_f)
end

puts "duration:"
laengen.each_with_index do |l,i|
  puts ".byte 0x%02x, 0x%02x, 0x%02x, 0x%02x ; [%02x] %-2s"   % [ l.on%256   , l.on/256   , l.off%256   , l.off/256   , i, l.name ]
  puts ".byte 0x%02x, 0x%02x, 0x%02x, 0x%02x ; [%02x] %-2s ." % [ l.onDot%256, l.onDot/256, l.offDot%256, l.offDot/256, i, l.name ]
  puts ".byte 0x%02x, 0x%02x, 0x%02x, 0x%02x ; [%02x] %-2s ~" % [ l.onSlr%256, l.onSlr/256, l.offSlr%256, l.offSlr/256, i, l.name ]
  puts ".byte 0x%02x, 0x%02x, 0x%02x, 0x%02x ;"               % [ 0          , 0          , 0           , 0                       ]
end
