;;VARIABLE DECLARATION
globals
[time
  pop ; total population at time t
  everpop ;total population including those who died
  newpop ; total population after the tick is over
  death ;death
  everdeath ;total deaths
  nb ;number of new births placeholder for each tick
  nm ;number of new migrants placeholder for each tick
  deathrate
  migrantpop
  nativepop
  numcitizens

  statelist ; list of states of origin
  originstatepr ; cumulative probability of migrant's state of origin
  stateruralpr ; state specific probability of rural or urban status
  stateruralfemalepr ;state specific rural migrants gender probability
  stateurbanfemalepr ;state specific urban migrants gender probabiliy
  reasonlist ; reason for migration list
  stateruralreasonpr ; state specific rural-urban migrants reason probability
  stateurbanreasonpr ; state specific rural-urban migrants reason probability
  stateruralreasonfemalepr ;state specific rural-urban migrants reasonwise female probability
  stateurbanreasonfemalepr ;state specific rural-urban migrants reasonwise female probability
  y ; temp variable
  za ; temp variable
  zb ; temp variable
  numstate ; number of states
  numreason ; number of resason
  n
  m
  k
  meanage
]

turtles-own
[
  age
  stay
  reasonmig
  ru ; rural or urban. rural = 1 and urban = 2
  gender ; migrant's gender. female = 1 male = 2
  originstate ;migrant's state of origin
  life
  los
]

breed [natives native]
breed [migrants migrant]

;;INITIATLIZATION OF MIGRATION MODULE
to setup
  __clear-all-and-reset-ticks ;clear everything from previous runs
  set n 35
  set k 0
  set m 2 * (lifeexp - n)

  crt InitNativePop
  [
    set breed natives
    set age random n
    set life n + random m
    set los random-exponential avglos
    set stay 0
  ]
  crt InitMigrantPop
  [
    set breed migrants
    set age random n
    set life n + random m
    set los random-exponential avglos
    set stay 0
  ]

  set meanage mean [age] of turtles
  set pop count natives
  set everpop 0

  set time 0
  set pop 0
  set everpop 0
  set numstate 5 ; number of origin states
  set statelist [0 1 2 3 4 5] ; test with five states. add "0" on zeroth position to simplify reference to elements. Eventually expand it to 34
  set originstatepr [0 0.2 0.5 0.7 0.9 1.0] ; cumulative probability of migrant's state of origin. Start with "0" and items will be exactly one more than number of states
  set stateruralpr [0 0.1 0.2 0.3 0.4 0.5] ; state specific probability of rural or urban status
  set stateruralfemalepr [0 0.2 0.2 0.2 0.2 0.2] ;state specific rural migrants gender probability
  set stateurbanfemalepr [0 0.7 0.7 0.7 0.7 0.7] ;state specific urban migrants gender probability
  set numreason 7; number of reasons for migration
  set reasonlist [0 1 2 3 4 5 6 7]
  set stateruralreasonpr    [0 0.0 0.0 0.0 0.0 0.0 0.0 0.0; first zeros
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0 ; first zero;reason probability for state 1 rural
    0 0.2 0.4 0.6 0.7 0.8 0.9 1.0 ; first zero ;reason probability for state 2 rural
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0
  ];rural reasons stop here
  set stateurbanreasonpr    [0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 ;urban reasons start here. first zeros
    0 0.2 0.5 0.6 0.7 0.8 0.9 1.0 ;first zero;rason probability for state 1 urban
    0 0.3 0.5 0.6 0.7 0.8 0.9 1.0
    0 0.4 0.5 0.6 0.7 0.8 0.9 1.0
    0 0.4 0.5 0.6 0.7 0.8 0.9 1.0
    0 0.4 0.5 0.6 0.7 0.8 0.9 1.0
  ] ; start with "0"
  set stateruralreasonfemalepr [0 0.0 0.0 0.0 0.0 0.0 0.0 0.0; first zeros
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0 ; first zero;female probability for state 1 rural;
    0 0.8 0.6 0.6 0.7 0.7 0.8 1.0
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0
    0 0.1 0.2 0.3 0.4 0.5 0.6 1.0
  ] ;rural reasons stop here
  set stateurbanreasonfemalepr [0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
    0 0.4 0.2 0.6 0.7 0.8 0.9 1.0 ;urban reasonwise females state 1
    0 0.2 0.5 0.6 0.7 0.8 0.9 1.0 ;urban reasonwise females state 2
    0 0.4 0.5 0.6 0.7 0.8 0.9 1.0
    0 0.4 0.5 0.6 0.7 0.8 0.9 1.0
    0 0.4 0.5 0.6 0.7 0.8 0.9 1.0
  ] ; start with "0"
  update-variables
end


;;SIMULATION RUN OF NATURAL GROWTH MODULE
to go
  set pop newpop
  newbirth
  newmigrants
  set everpop everpop + nb + nm
  kill-citizens
  out-migrate
  set newpop count turtles
  set time time + 1
  update-citizens
  set meanage mean [age] of turtles
  update-variables
  if ticks = T [stop]
  tick
end

;; TO CREATE natives
to newbirth
  set nb random-poisson (CrudeBirthrate * pop / 1000)
  crt nb
  [set breed natives
    set life n + random m
    set age 0
    set los random-exponential avglos
    set stay 0
  ]
end

to newmigrants
  set nm random-poisson avgmigrationrate
  set nm nm * (1 + InflatoryIndex)
  crt nm
    [set breed migrants
      set age k + random n
      set life n + random m
      set los random-exponential avglos
      set stay 0

      let s random-float 1 ; state of origin starts here
      set y 1
      while [y < (numstate + 1)]
      [if (s < item y originstatepr) and (s > item (y - 1) originstatepr)
        [set originstate item y statelist
          let sr random-float 1 ; rural urban status starts here
          ifelse sr < item y stateruralpr
          [set ru 1
            let rrm random-float 1; reason for migration starts here
            set za 1
            while [za < (numreason + 1)]
            [if (rrm < item (((numreason + 1) * y) + za) stateruralreasonpr) and (rrm > item (((numreason + 1) * y) + (za - 1)) stateruralreasonpr)
              [set reasonmig item za reasonlist
                let rrmg random-float 1; gender starts here
                ifelse (rrmg < item (((numreason + 1) * y) + za) stateruralreasonfemalepr) and (rrmg > item (((numreason + 1) * y) + (za - 1)) stateruralreasonfemalepr)
                [set gender 1][set gender 2]
              ]
              set za za + 1]
          ]
          [set ru 2
            let urm random-float 1; reason for migration starts here
            set zb 1
            while [zb < (numreason)]
            [if (urm < item (((numreason + 1) * y) + zb) stateurbanreasonpr) and (urm > item (((numreason + 1) * y) + (zb - 1)) stateurbanreasonpr)
              [set reasonmig item zb reasonlist
                let urmg random-float 1; gender starts here
                ifelse (urmg < item (((numreason + 1) * y) + zb) stateurbanreasonfemalepr) and (urmg > item (((numreason + 1) * y) + (zb - 1)) stateurbanreasonfemalepr)
                [set gender 1][set gender 2]
              ]
              set zb zb + 1]
          ]
        ]
        set y y + 1
      ]
  ]
end
;; UPDATE-NATIVES
to update-citizens
  ask turtles
  [set age age + 1]
end
to update-migrants
  ask migrants
  [set stay stay + 1]
end

;;DEATH
to kill-citizens
  set death count turtles with [age > life]
  set everdeath everdeath + death
  ask turtles [if age > life [die]]
end

;;OUT-MIGRATION
to out-migrate
  ask turtles [if stay > los [die]    ]
end



to update-variables
  if pop > 0 [
    set deathrate death / (pop / 1000)]
  set migrantpop count migrants
  set nativepop count natives
  set numcitizens count turtles
end
@#$#@#$#@
GRAPHICS-WINDOW
141
29
314
203
-1
-1
23.6
1
10
1
1
1
0
1
1
1
-3
3
-3
3
1
1
1
ticks
30.0

BUTTON
8
72
78
106
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
9
31
78
64
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
80
31
135
107
T
1.0
1
0
Number

MONITOR
616
26
755
71
Births + Migrants Per Year
everpop / time
0
1
11

INPUTBOX
7
234
135
294
CrudeBirthRate
1.0
1
0
Number

TEXTBOX
14
10
164
28
Inputs
12
0.0
1

TEXTBOX
314
10
464
28
Outputs
12
0.0
1

INPUTBOX
7
295
135
355
lifeexp
1.0
1
0
Number

MONITOR
311
215
397
260
Population
numcitizens
0
1
11

INPUTBOX
7
108
135
168
InitNativePop
1.0
1
0
Number

MONITOR
616
72
755
117
Avg Age
meanage
1
1
11

MONITOR
616
119
755
164
Death Rate
deathrate
2
1
11

PLOT
311
26
614
213
Population Growth
Years
Number of People
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "plot count turtles"

MONITOR
507
215
614
260
Number of Migrants
migrantpop
0
1
11

MONITOR
399
214
506
259
Number of Natives
nativepop
0
1
11

INPUTBOX
7
172
136
232
InitMigrantPop
1.0
1
0
Number

INPUTBOX
7
356
135
416
avgmigrationrate
1.0
1
0
Number

SLIDER
6
480
135
513
InflatoryIndex
InflatoryIndex
0
1
0.44
0.01
1
NIL
HORIZONTAL

INPUTBOX
7
419
135
479
avglos
1.0
1
0
Number

TEXTBOX
150
220
300
262
Before hitting setup, enter all the input parameters first.
11
0.0
1

@#$#@#$#@
## WHAT IS IT?

Migration Module for Slumulation

## HOW IT WORKS

New agents are created from a poisson distribution. Mean number of migrants per day is calculated empirically and provided as input.

## HOW TO USE IT

'avgdailymigrationrate' is the number of migrants per day, calculated from the migration table of the census
'T' is the simulation run time in number of days

## THINGS TO NOTICE

Everyday, different number of migrants arrive to the city. However, average migration remains the same as specified by the user as an input. It is asusmed that the arrival process follows poisson distribution.

## THINGS TO TRY

Try changing the number of migrants per day, number of days to be simulated etc. to see when does the model achieve equilibrium.

## EXTENDING THE MODEL
join probabilities for reason for migration, gender, origin state etc.

## NETLOGO FEATURES

No work around was needed.

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

Patel (2012). Microsimulating agents using Descrete Event Simulation in Netlogo Environment.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Experiment 1 Steady State" repetitions="30" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>meanage</metric>
    <metric>deathrate</metric>
    <enumeratedValueSet variable="t">
      <value value="100"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Experiment 2 1991-2001" repetitions="30" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>numcitizens</metric>
    <metric>nativepop</metric>
    <metric>migrantpop</metric>
    <enumeratedValueSet variable="InitMigrantPop">
      <value value="11151"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CrudeBirthRate">
      <value value="23.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="T">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="InflatoryIndex">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="InitNativePop">
      <value value="21970"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avgmigrationrate">
      <value value="428"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lifeexp">
      <value value="62"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1000" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>nativepop</metric>
    <metric>migrantpop</metric>
    <metric>numcitizens</metric>
    <enumeratedValueSet variable="InitNativePop">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avglos">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="InitMigrantPop">
      <value value="500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="avgmigrationrate">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="lifeexp">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="CrudeBirthRate">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="T">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="InflatoryIndex">
      <value value="0.15"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
