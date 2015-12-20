# coding: utf-8
################################################################################
# (c) 2015 Andreas Müller
#     see LICENSE.md
################################################################################

################################################################################
# Ly2Asm
################################################################################

class Ly2Asm

  def initialize()

    @ReNote = /(ces|cis|c|des|dis|d|ees|eis|e|fes|fis|f|ges|gis|g|aes|ais|a|bes|bis|b|r)([,'])?((?:64|32|16|8|4|2|1)\.?)?[\[\]]?([~\(\)])?/

    @Hoehe = {
      'c'   =>  0,
      'cis' =>  1,
      'des' =>  1,
      'd'   =>  2,
      'dis' =>  3,
      'ees' =>  3,
      'e'   =>  4,
      'eis' =>  5,
      'fes' =>  4,
      'f'   =>  5,
      'fis' =>  6,
      'ges' =>  6,
      'g'   =>  7,
      'gis' =>  8,
      'aes' =>  8,
      'a'   =>  9,
      'ais' => 10,
      'bes' => 10,
      'b'   => 11,
      'bis' =>  0,
      'ces' => 11,
    }

    @Dauer = {
      '1'   => 0x00 << 2,
      '1.'  => 0x01 << 2,
      '2'   => 0x02 << 2,
      '2.'  => 0x03 << 2,
      '4'   => 0x04 << 2,
      '4.'  => 0x05 << 2,
      '8'   => 0x06 << 2,
      '8.'  => 0x07 << 2,
      '16'  => 0x08 << 2,
      '16.' => 0x09 << 2,
      '32'  => 0x0a << 2,
      '32.' => 0x0b << 2,
      '64'  => 0x0c << 2,
      '64.' => 0x0d << 2,
    }

    @toc = []
  end

  def convert(song)

    data(song[:title], song[:sections])
    @toc << song
    
  end

  def toc()
    puts "toc:"
    @toc.each_with_index do |song, idx|
      puts "\t.word %sToc\t; %d" % [ song[:title], idx ]
    end
    puts "\t.word 0xffff\t; return"
    
    @toc.each do |song|
      puts song[:title] + "Toc:"
      puts "\t.byte 0x%02x\t; speed" % song[:speed]
      puts "\t.byte 0x00\t; padding"
      song[:order].each_with_index { |iSec,idx| puts "\t.word %sData%d\t; %d" % [ song[:title], iSec, idx ] }
      puts "\t.word 0xffff\t; return"      
    end
  end    

  private

  def data(name, music)
    hoehe0 = 9
    hoehe = 0x21
    dauer = 0x00
    bogen = false
    dauer0 = '4'
    
    music.each_with_index do |section, index|
      puts "#{name}Data#{index+1}:"

      section.scan(@ReNote).each_with_index do |n, idx|
        nHoehe, nOktav, nDauer, nBogen = n

        if (nDauer)
          dauer0 = nDauer
        else
          nDauer = dauer0
        end
        
        if (nHoehe == 'r')
          h = 0xff
          d = @Dauer[nDauer] | 2
          puts "\t.byte 0x%02x, 0x%02x ; [%3d] %-4s %s" % [ h, d, idx, '-', nDauer ]
        else
          nHoehe = @Hoehe[nHoehe]
          deltaT = nHoehe - hoehe0

          if deltaT < -6
            deltaT += 12
          elsif deltaT > +6
            deltaT -= 12
          end

          case nOktav
          when ','
            hoehe0 = hoehe0 + deltaT - 12
            hoehe  = hoehe  + deltaT - 12
          when '\''
            hoehe0 = hoehe0 + deltaT + 12
            hoehe  = hoehe  + deltaT + 12
          when nil
            hoehe0 = hoehe0 + deltaT
            hoehe  = hoehe  + deltaT
          end
          hoehe0 = hoehe0 % 12
          
          bogen = true  if nBogen == '(' || nBogen == '~'
          bogen = false if nBogen == ')'
          dauer = @Dauer[nDauer]
          dauer |= 2 if bogen
          bogen = false if nBogen == '~'

          cmt1  = n[0]
          cmt1 += nOktav if nOktav
          cmt2  = nDauer
          cmt2 += nBogen if nBogen
        
          puts "\t.byte 0x%02x, 0x%02x ; [%3d] %-4s %s" % [ hoehe, dauer, idx, cmt1, cmt2 ]
        end
      end
      puts "\t.word 0xffff     ; return"
    end

    puts
    
  end
end

################################################################################
# Songs
################################################################################

Bourree = 
  {
    :title => 'Bourree',
    :speed => 150,
    :sections =>
    [
      #1
      %q[ d8( e8) |
          f4 e8( d8) cis4 d8( e8) | a,4 b8( cis8) d4 c8( bes8) | a4 g8( f8) e4 f8( g8) | a8( g8 f8 e8 d4) d'8( e8)  |
          f4  e8( d8) cis4 d8( e8) | a,4 b8( cis8) d4 c8( bes8) | a4 g8( f8) e4. ],
      #2             
      %q[  f8 f2. ],
      #3
      %q[ d8 | d2.]
    ],
    :order => [1,2,1,2,1,3]
  }

Entertainer = 
  {
    :title => 'Entertainer',
    :speed => 120,
    :sections =>
    [
      #1
      %q[ d'8 e8 c8 a8~ a8 b8 g4 | d8 e8 c8 a8~ a8 b8 g4 | d8 e8 c8 a8~ a8 b8 a8 gis8 | g4 r4 g'4 d8 dis8 ],
      #2
      %q[ e8 c'4 e,8 c'4 e,8 c'8~ | c2~ c8 c8 d8 dis8 | e8 c8 d8 e8~ e8 b8 d4 | c2. d,8 dis8 |
          e8 c'4 e,8 c'4 e,8 c'8~ | c2. a8 g8 | fis 8 a8 c8 e8~ e8 d8 c8 a8 | d2. d,8 dis8 |
          e8 c'4 e,8 c'4 e,8 c'8~ | c2~ c8 c8 d8 dis8 | e8 c8 d8 e8~ e8 b8 d4 | c2. c8 d8 |
          e8 c8 d8 e8~ e8 c8 d8 c8 | e8 c8 d8 e8~ e8 c8 d8 c8 | e8 c8 d8 e8~ e8 b8 d4 ],
      #3
      %q[ g4 a8 g8~ g8 e8 f8 fis8 | g4 a8 g8~ g8 e8 c8 g8 | a8 b8 c8 d8 e8 d8 c8 d8 | g,8 e'8 f8 g8 a8 g8 e8 f8 |
          g4 a8 g8~ g8 e8 f8 fis8 | g4 a8 g8~ g8 g8 a8 ais8 | b8 b4 b8~ b8 a8 fis8 d8 | g2~ g8 e8 f8 fis8 |
          g4 a8 g8~ g8 e8 f8 fis8 | g4 a8 g8~ g8 e8 c8 g8 | a8 b8 c8 d8 e8 d8 c8 d8 | c2~ c8 g8 fis8 g8 |
          c4 a8 c8~ c8 a8 c8 a8 | g8 c8 e8 g8~ g8 e8 c8 g8 | a4 c4 e8 d4 c8~ ],
      #4
      %q[ c2. d,8 dis8 ],
      #5
      %q[ c'2~ c8 e8 f8 fis8 ],
      #6
      %q[ c4 r4 c'4 r4 ],
    ],
    :order => [1, 2, 4, 2, 5, 3, 5, 3, 4, 2, 6 ]
  }

################################################################################
# Weihnachtslieder von https://github.com/Musikpiraten/public-domain-season-songs
################################################################################

FroehlicheWeihnachtUeberall =
  {
    :title => 'FroehlicheWeihnachtUeberall',
    :speed => 140,
    :sections =>
    [
      %q< d8([ c)] b c d4 b g4 a b4 r4 b8 a g a b4 g d4 fis g4 r4 >,
      %q< a4 d d2 b4 d d2 a4 e' d b d c8 ([ b)] a2 >,
      %q< a4. b8 c4 a b( c) d2 e4 d c b c2. r4 >,
      %q< a4. b8 c4 a b c d2 d,4 b' b a g2. r4 >,
    ],
    :order => [ 1, 2, 1, 3, 4,
                1, 2, 1, 3, 4 ]
  }

AlleJahreWieder =
  {
    :title => 'AlleJahreWieder',
    :speed => 190,
    :sections =>
    [
      %q< a4. b8 a4 g | fis2 e | d4 e8[ fis] g4 fis | e2. r4 | fis4 a b a | d2 cis4( b) |
          a g8[ fis] g4 a | fis2. r4 >
    ],
    :order => [ 1, 1]
  }

IhrKinderleinKommet =
  {
    :title => 'IhrKinderleinKommet',
    :speed => 200,
    :sections =>
    [
      %q< a8 | a4 fis8 a | a4 fis8 a | g4 e8 g | fis4 r8 a |
          a4 fis8 a | a4 fis8 a |
          g4 e8 g | fis4 r8 fis |
          e4 e8 e | g4 g8 g | fis4 fis8 fis | b4 r8 b |
          a4 a8 a | d4 a8 fis | a4 g8 e | d4. r8 >
    ],
    :order => [ 1, 1 ]
  }

JosephLieberjosephMein =
  {
    :title => 'JosephLieberjosephMein',
    :speed => 220,
    :sections =>
    [
      %q< c4 a8 f4 a8 | c4 d8 c4. | c4 a8 f4 a8 | c4 d8 c4. | bes4 bes8 bes4 c8 |
          bes4 a8 g4 a8 | c4 a8 f4 a8 | g4 f8 g4 a8 | f4. f4.>
    ],
    :order => [ 1, 1 ]
  }

KlingGloeckchenKlingelingeling =
  {
    :title => 'KlingGloeckchenKlingelingeling',
    :speed => 150,
    :sections =>
    [
      %q< c2 a4 bes4 c8 d c d c2 bes g4 c a1
          g4 g a f a2 g bes4 bes c g bes2 a
          g4 g a b c2 g a4 d c b d2 c 
          c2 a4 bes4 c8 d c d c2 bes g4 c a1>
    ],
    :order => [ 1, 1 ]
  }

JingleBells =
  {
    :title => 'JingleBells',
    :speed => 150,
    :sections =>
    [
      %q< d8 b' a g d4. d16 d d8 b' a g e2 e8 c' b a fis2 d'8 d c a b2 d,8 b' a g d2 
          d8 b' a g e4. e8 e c' b a d d d d e d c a g4 r b8 b b4 b8 b b4 b8 d g,8. a16 
          b2 c8 c c8. c16 c8 b b b16 b b8 a a b a4( d) b8 b b4 b8 b b4 b8 d g,8. a16 
          b2 c8  c c8. c16 c8 b b b16 b d8 d c a g2>
    ],
    :order => [ 1, 1 ]
  }

LasstUnsFrohUndMunterSein =
  {
    :title => 'LasstUnsFrohUndMunterSein',
    :speed => 150,
    :sections =>
    [
      %q< a4 a4 a8[ b8] a8[ g8]
          fis4 fis4 fis4 r4
          g4 g4 g8[ a8] g8[ fis8]
          e4 e4 e4 r4
          d4 e4 fis4 g4
          a8. b16 a8 b8 a2
          d4 a4 a8[ b8] a8[ g8]
          fis4 e4 a2
          d4 a4 a8[ b8] a8[ g8]
          fis4 e4 d2>
    ],
    :order => [ 1, 1 ]
  }

StilleNachHeiligeNacht =
  {
    :title => 'StilleNachHeiligeNacht',
    :speed => 255,
    :sections =>
    [
      %q< a8.( b16) a8 fis4. | a8. b16 a8 fis4. |
          e'4 e8 cis4. | d4 d8 a4. |
          b4 b8 d8.( cis16) b8 | a8.( b16) a8 fis4. |
          b4 b8 d8.( cis16) b8 | a8.( b16) a8 fis4. |
          e'4 e8 g8. e16 cis8 | d4.( fis4.) |
          d8.( a16) fis8 a8. g16 e8 | d4.( d4) r8
    >
    ],
    :order => [ 1, 1 ]
  }

WeWishYouAMerryChristmas =
  {
    :title => 'WeWishYouAMerryChristmas',
    :speed => 100,
    :sections =>
    [
      %q< a4 d d8 e d cis b4 b b e e8 fis e d cis4 a a fis' fis8 g fis e d4 b a8 a 
          b4 e cis d2 a4 d d d cis2 cis4 d4  cis b a2 e'4 fis e8 e d d a'4
          fis a,8 a b4 e cis d2 >
    ],
    :order => [ 1, 1 ]
  }

AmWeihnachtsbaumeDieLichterBrennen =
  {
    :title => 'AmWeihnachtsbaumeDieLichterBrennen',
    :speed => 200,
    :sections =>
    [
      %q< c8 c8 e8 | g4 e8 g c a |
          g4 e8 g a g |
          f4 d g8 g |
          e4 r8 e e g |
          f4 d8 f f a
          g4 e8 e e g |
          f4 d g8 g |
          e4 r8 >
    ],
    :order => [ 1, 1 ]
  }

EsIstEinRosEntsprungen =
  {
    :title => 'EsIstEinRosEntsprungen',
    :speed => 200,
    :sections =>
    [
      %q< c2 c4 c d c c2 a bes a4 g~ g f2 e4  f2 c'
          c4 c d c c2 a bes a4 g~ g f2 e4 f2 r4 a
          g4 e f d c2. r4 c' c c d c c2 a bes a4 g~ g f2 e4 f2 >
    ],
    :order => [ 1, 1 ]
  }

KommetIhrHirten =
  {
    :title => 'KommetIhrHirten',
    :speed => 150,
    :sections =>
    [
      %q< c'4 c8([ a)] d[( bes)] | c4 c8[( a)] d[( bes)] |
          c4 a8[( c)] g[( a)] | f2. >,
      %q< f4 a8 f a c | f,4 a8 f g c, |
          f4 a8 f a c | f,4 a8 f g c, |
          c'4 a8[( c)] g[( a)] | f2. >
    ],
    :order => [ 1, 1, 2, 1, 1, 2 ]
  }

LeiseRieseltDerSchnee =
  {
    :title => 'LeiseRieseltDerSchnee',
    :speed => 220,
    :sections =>
    [
      %q< a'4 a8 g a g | f4.~ f4 r8 |
          f4 d8 f e d | c4.~ c4 r8 |
          g'8 fis g bes a g | f4.~ f4 r8 |
          g8. d16 d8 e d e | f4.~ f4 r8 >
    ],
    :order => [ 1, 1 ]
  }

MachtHochDieTuer =
  {
    :title => 'MachtHochDieTuer',
    :speed => 150,
    :sections =>
    [
      %q< g'4 | bes2 aes4 g2 f4 | ees( f) g f2 bes4 |
          aes2 aes4 g2 g4 | f( ees) f ees2 g4 |
          f2 f4 g( a) bes | bes( c) a bes2 f4 |
          g2 f4 g( a) bes | bes( c) a bes2 bes4 |
          c2 bes4 c2 bes4 | c( bes) aes g2 bes4 |
          c2 bes4 c2 bes4 | c( bes) aes g2 bes4 |
          ees,2 ees4 aes2 g4 | f2.~ f2 bes4 |
          aes2 g4 f( ees) f | ees2.~ ees2 >
    ],
    :order => [ 1, 1 ]
  }

MorgenKommtDerWeihnachtsmann =
  {
    :title => 'MorgenKommtDerWeihnachtsmann',
    :speed => 140,
    :sections =>
    [
      %q< g4 g d' d e e d2 c4 c b b a2 g
          d'4 d c c b b a2 d4 d c c b b a2
          g4 g d' d e e d2 c4 c b b a2 g >
    ],
    :order => [ 1, 1 ]
  }

MorgenKinderWirdsWasGeben =
  {
    :title => 'MorgenKinderWirdsWasGeben',
    :speed => 150,
    :sections =>
    [
      %q< g'4 d e d | e8( g) fis( a) g4 d |
          b' b8( c) d4 b | c b a2 | >,
      %q< c4 c e e | a, a d2 |
          g,4 g c c | b8( a) g( fis) g2 >
    ],
    :order => [ 1, 1, 2, 1, 1, 2 ]
  }

ODuFroehliche =
  {
    :title => 'ODuFroehliche',
    :speed => 190,
    :sections =>
    [
      %q< a'2 b | a4. g8 fis4( g) | a2 b | a4. g8 fis4( g) |
          a2 a | b cis4 d | cis2 b | a1 |
          e4.( fis8) e4 fis | g4.( a8) g2 | fis4.( g8) fis4 g | a4.( b8) a2 |
          d4( cis) b( a) | d b a g | fis2 e | d1 >
    ],
    :order => [ 1, 1 ]
  }

OTannenbaum =
  {
    :title => 'OTannenbaum',
    :speed => 180,
    :sections =>
    [
      %q< c f8. f16 f4. g8 a8. a16 a4. a8 g8 a bes4 e
          g f r8 c' c a d4. c8 c bes bes4. bes8
          bes g c4. bes8 bes a a4. c,8 f8. f16 f4. g8
          a8. a16 a4. a8 g8 a bes4 e g f2 >
    ],
    :order => [ 1, 1 ]
  }

SuesserDieGlockenNieKlingen =
  {
    :title => 'SuesserDieGlockenNieKlingen',
    :speed => 180,
    :sections =>
    [
      %q< a8. a16 a8 a g a | c4. g | g8. g16 g8 g(f) g |
          a4.( a4) r8 | c8. c16 c8 c a f | f'4. d |
          c8. d16 c8 c bes g | f4.( f4) r8 | g8. g16 g8 a a a |
          c8. bes16 g8 a4. | g8. g16 g8 a a a | c8. bes16 g8 a4. |
          c8. bes16 a8 a g f | f'4.(d) | c8. d16 c8 c bes g | f4.( f4) r8 >
    ],
    :order => [ 1, 1 ]
  }

TochterZionFreueDich =
  {
    :title => 'TochterZionFreueDich',
    :speed => 180,
    :sections =>
    [
      %q< bes'2 g4.( aes8) | bes2 ees, |
          f8([ g aes bes] aes4) g | f1 |
          g8([ aes bes c]) bes4 bes | ees2 bes |
          aes4( g f4.) ees8 | ees1 | >,
      %q< g8([ f g aes] g4) g | f2 ees |
          aes4( g f) ees | d1 |
          ees8([ d ees f] ees4) ees | c'2 a |
          bes4( c8[ bes] a4.) bes8 | bes1 >
    ],
    :order => [ 1, 2, 1, 1, 2, 1 ]
  }

VomHimmelhochDaKommIchHer =
  {
    :title => 'VomHimmelhochDaKommIchHer',
    :speed => 150,
    :sections =>
    [
      %q< c4 b4 a b g a b c
        r8 c c4 g g e g f e
        r8 e a4 a g b c a g
        r8 c b4 a g8 g a4 f8( e) d4 c2 r4. >
    ],
    :order => [ 1, 1 ]
  }

WasSollDasBedeuten =
  {
    :title => 'WasSollDasBedeuten',
    :speed => 150,
    :sections =>
    [
      %q< g'8( a) >,
      %q< b4 b a8( b) c4 c b8( c) d4 d c8( b) >,
      %q< a2 g8( a) >,
      %q< a2 r4 >,
      %q< a4 a8( g) a( c) b2 r4 b4 b8( a) b( c) a2 d8( c)
	  b4 d c8( b) a( b) c4 b8( a) g( a) b4 a g2 r4 >
    ],
    :order => [ 1, 2, 3, 2, 4, 5, 1, 2, 3, 2, 4, 5 ]
  }

ZuBethlehemGeboren =
  {
    :title => 'ZuBethlehemGeboren',
    :speed => 150,
    :sections =>
    [
      %q< c4 f4. g8 a4 g | f2 e4 f | g f8( g) a4 g |
          f2 r4 c' | c a bes c | d2 bes4 bes |
          a( bes c) bes8 a | g2. r4 | c2 g |
          a g4 a8( bes) | c4 f,8( g) a4 g | f2. r4 >
    ],
    :order => [ 1, 1 ]
  }

################################################################################
# main
################################################################################

puts "; generated by Ly2Asm.rb"
puts

ly2asm = Ly2Asm.new

[
  # Songs
#  Bourree,
#  Entertainer,
  
  # Weihnachtslieder
  FroehlicheWeihnachtUeberall,
  AlleJahreWieder,
  IhrKinderleinKommet,
  JosephLieberjosephMein,
  KlingGloeckchenKlingelingeling,
  JingleBells,
  LasstUnsFrohUndMunterSein,
  StilleNachHeiligeNacht,
  WeWishYouAMerryChristmas,
  AmWeihnachtsbaumeDieLichterBrennen,
  EsIstEinRosEntsprungen,
  KommetIhrHirten,
  LeiseRieseltDerSchnee,
  MachtHochDieTuer,
  MorgenKinderWirdsWasGeben,
  ODuFroehliche,
  OTannenbaum,
  SuesserDieGlockenNieKlingen,
  TochterZionFreueDich,
  VomHimmelhochDaKommIchHer,
  WasSollDasBedeuten,
  ZuBethlehemGeboren,
].each { |song| ly2asm.convert(song) }

ly2asm.toc()

__END__

################################################################################
# template
################################################################################

songs <<
{
  :title => '',
  :speed => 150,
  :sections =>
  [
    %q<
    >
  ],
  :order => [ 1 ]
}

################################################################################
# EOF
################################################################################
