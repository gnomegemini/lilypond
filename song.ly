% Die Angabe der Versionsnummer stellt sicher, dass die Datei mit dem Programm convert-ly konvertiert werden kann.
\version "2.12.3"

% Um die Noten auf eine Seite einzupassen, kann die Größe der Systeme per Hand angepasst werden.
#(set-global-staff-size 20)

% Im sogenannten "header" kann man Überschriften u.Ä. setzen.
\header {
        title    = "Belle, qui tiens ma vie"
        composer = "Musik: Thoinot Arbeau (1520-1595)"
        arranger = "Aus \"Orchésgraphie\" (1589)"
        poet     = "Text: 16. Jh."
        tagline  = "- 1 -"
}

global = {
        \key f \major
        \time 2/2
}

% Die Noten können als Variablen abgespeichert werden, damit man im sogenannten "score" Block auf sie zurückgreifen kann.
% Somit können komplexere Dokumente gut strukturiert werden.
SopranNoten = \relative c' {
                \repeat volta 2 { \partial 2 g2 g4 fis g a bes2 bes4 d c bes bes a bes2 } \break
                bes2 \repeat volta 2 { a4 a g g fis2 d e8( f) g4 g fis }
                \alternative { { g2 bes } { g } } \bar "|."
}
AltNoten = \relative c''' {
                \repeat volta 2 { \partial 2 d2 d4 d d f f2 f4 f e f g f f2 }
                f2 \repeat volta 2 { f4 f d es d2 f c4 d d d }
                \alternative { { b2 d } { d } }
}
TenorNoten = \relative c' {
                \repeat volta 2{ \partial 2 bes2 bes4 a bes c d2 d4 bes g d' c c d2 }
                d \repeat volta 2 {c4 e bes c a2 bes g4 bes a a}
                \alternative { { g2 bes } { g } }
}
BassNoten = \relative c' {
                \repeat volta 2 { \partial 2 g2 g4 d g f bes,2 bes4 bes c d es f bes,2 }
                bes'2 \repeat volta 2 { f4 d g c, d2 bes c4 g d' d }
                \alternative { { g,2 g' } { g, } }
}
stropheEins = \lyricmode {
        \set stanza = "1. " Bel -- le, qui tiens ma vi -- e cap -- ti -- ve dans tes yeux,
        viens tôt me se -- cou -- rir, ou me __ fau -- dra mou -- rir, viens rir.
}
stropheEinsWiederholung = \lyricmode {
        qui m'as l'â -- me ra -- vi -- e d'un sou -- riz gra -- ci -- eux,
}
stropheZwei = \lyricmode {
        \set stanza = "2. " Pour -- quoi fuis -- tu, mi -- gnar -- de, si je suis près de toy,
        car tes per -- fec -- ti -- ons chan -- gent __ mes ac -- ti -- ons, car ons.
}
stropheZweiWiederholung = \lyricmode {
        quand tex yeux je re -- gar -- de je me perds de -- dans moy,
}
stropheDrei = \lyricmode {
        \set stanza = "3. " Ap -- pro -- che donc ma bel -- le, ap -- pro -- che toy mon bien,
        pour mon mal ap -- pai -- ser, don -- ne __ moy un bai -- ser. pour ser.
}
stropheDreiWiederholung = \lyricmode {
        ne me sous plus re -- bel -- le puis -- que mon coeur est tien,
}

% Im score-Block wird die Gestaltung der Seite festgesetzt.
\score {
        <<
                \new ChoirStaff <<
                        \new Staff <<
                                \new Voice  { \voiceOne << \global \SopranNoten >> }
                                \new Voice  { \voiceTwo << \global \AltNoten >> }
                                \addlyrics { \stropheEins }
                                \addlyrics { \stropheEinsWiederholung }
                                \addlyrics { \stropheZwei }
                                \addlyrics { \stropheZweiWiederholung }
                                \addlyrics { \stropheDrei }
                                \addlyrics { \stropheDreiWiederholung }
                        >>
                        \new Staff  <<
                                \new Voice  { \voiceOne << \global \clef bass  \TenorNoten >> }
                                \new Voice  { \voiceTwo << \global \clef bass  \BassNoten >> }
                                \addlyrics { \stropheEins }
                                \addlyrics { \stropheEinsWiederholung }
                        >>
                >>
        >>
}

% Das Stück beinhaltet Wiederholungen, die von der Midi-Ausgabe nicht berücksichtigt werden.
% Um die Wiederholungen in der Midi-Datei auszuspielen, gibt es die Option "unfoldRepeats"
\score {
                \new ChoirStaff <<
                        \new Staff  <<
                                \new Voice  { \global \unfoldRepeats \SopranNoten }
                        >>
                        \new Staff  <<
                                \new Voice  { \global \unfoldRepeats \AltNoten }
                        >>
                        \new Staff  <<
                                \new Voice { \global \unfoldRepeats \TenorNoten }
                        >>
                        \new Staff  <<
                                \new Voice { \global \unfoldRepeats \BassNoten }
                        >>
                >>
   \midi {
     \context {
       \Score
       tempoWholesPerMinute = #(ly:make-moment 120 4)
       }
   }
}
