breed [developers developer] ; developers hold a vaccant property. Add to existing housing stock on that site. Holds it untill all units are occupied.
breed [hhheads hhhead] ; hhheads. Make their housing decisions. KILL THIS BREED FOR INTEGRATION.
breed [hhmembers hhmember]
breed [newcomers newcomer]
breed [movingmembers movingmember] ;TEMPORARY BREED TO MAKE THE COMPUTING FASTER.

;;SECTION 1. VARIABLE DECLARATION
;********************************
;GLOBAL VARIABLE DECLARATION
 globals
 [num-developers ;number of developers in the city (for monitoring purpose during model development and verification)

  max-rent ;initial maximum rent
  min-rent ;initial lowest rent (calculated based on inequality level specified by the user).
  highestrent;highest rent in the city during the simulation (most prime property)
  lowestrent ;lowerst rent in the city during the simulation (most inappropriate property)

  red-averagerent; to keep track of average rents of poor people in the city
  green-averagerent; to keep track of average rents of rich people in the city
  blue-averagerent; to keep track of average rents of middle-class peopel in the city

  red-count; to keep track of number of poor people
  blue-count; to keep track of number of middle-class people
  green-count; to keep track of number of rich people

  red-density; to keep track of poor people's housing density
  blue-density; to keep track of middle-class people's hosuing density
  green-density; to keep track of rich people's housing density

  slum-density; to keep track of density in slums
  central-slum-density
  periphery-slum-density

  avg-density; average density in the city

  num-searching ;to keep track of how many people are searching house during simulation

  cityincome ;total income of the entire economy. updated every iteration.

  income-red ;share of income of lower income group people
  income-blue ;share of income of middle income group people
  income-green ;share of income of higher income group people

  avg-income ;average income

  avg-income-red ; average income of poor
  avg-income-blue ;average income of middle-class
  avg-income-green ;average income of rich

  population ;total population of the city

  slumpop ;total slum population of the city
  centralslumpop ; slum population in the central city
  peripheralslumpop ;slum population in the periphery

  slumpoppercent ; percentage slum population  of the city
  centralslumpoppercent ; central city slum population
  peripheryslumpoppercent ; peripheral slum population

  num-slums ; number of slums in the city
  central-num-slums ; number of slums in central city
  peripheral-num-slums ;number of slums in peripheral city

  smallest-slum
  largest-slum

  slumareapercent
  centralslumareapercent
  peripheryslumareapercent

  ward1pop ;ward 1 population
  ward2pop ;ward 2 population
  ward3pop ;ward 3 population
  ward4pop ;ward 4 population
  ward5pop ;ward 5 population
  ward6pop ;ward 6 population
  ward7pop ;ward 7 population
  ward8pop ;ward 8 population
  ward9pop ;ward 9 population

  ward1slumpop ;ward 1 slum population
  ward2slumpop ;ward 2 slum population
  ward3slumpop ;ward 3 slum population
  ward4slumpop ;ward 4 slum population
  ward5slumpop ;ward 5 slum population
  ward6slumpop ;ward 6 slum population
  ward7slumpop ;ward 7 slum population
  ward8slumpop ;ward 8 slum population
  ward9slumpop ;ward 9 slum population

  ward1slumpoppercent ;ward 1 slum population in percent
  ward2slumpoppercent ;ward 2 slum population in percent
  ward3slumpoppercent ;ward 3 slum population in percent
  ward4slumpoppercent ;ward 4 slum population in percent
  ward5slumpoppercent ;ward 5 slum population in percent
  ward6slumpoppercent ;ward 6 slum population in percent
  ward7slumpoppercent ;ward 7 slum population in percent
  ward8slumpoppercent ;ward 8 slum population in percent
  ward9slumpoppercent ;ward 9 slum population in percent

  target ;placeholder of a patch until entire family moves-in

  n ;from DES2ABM
  k
  m


  meanage

  reasonpr
  reasonlist ; reason for migration list
  y ; temp variable
  za ; temp variable
  zb ; temp variable
  numstate ; number of states
  numreason ; number of resason

  deathrate

  death ;number of deaths this tick
  everdeath ;total deaths over entire simulation pepriod
  nb ;number of new births placeholder for each tick
  nm ;number of new migrants placeholder for each tick

  migrantpop
  nativepop
  numcitizens


  MigRate
  InflatoryIndex ;to boost migration rate (compensate for uncounted out-migration and reverse-migraiton)
  ]

 ;TURTLES (AGENTS) VARIABLE DECLARATION
 developers-own ;developer agents' variables
 [no-role?] ; to see if they have no role on that patch

 hhheads-own
 ;household agents' variables
 [income ;hhheads income
  informal? ; household works in informal sector? bulion.
  searching? ; if migrant is searching for new house - set to true when migrant arrives first time or dissatisfied with the place and set to false once found the place
  willing? ; if resident is willing to share the house in face of rising rents
  class-updated? ;temporary variable to make sure that each person's class is updated at the end of each iteration
  old ; to record how long resident has been at this city? ;for further analysis on residential mobility
  stay; to record how long resident has been at this site? ;only available for the current residence; for further analysis on residential mobility
  los;
  stayc;
  num-houses ;to record how many houses hhheads have changed ;for further analysis on residential mobility
  hhsize ;
  native? ;native or migrant
  age ;
  life ;
  reasonmig ;reason for migration. reason 1 = ...
  ru ; rural or urban. rural = 1 and urban = 2
  gender ; migrant's gender. female = 1 male = 2
  originstate ;migrant's state of origin

  hh? ;part of household or not
  hhid ;household ID
  hhsizelimit
 ]

 hhmembers-own
 ;household agents' variables
 [native? ;native or migrant
  age ;
  life ;
  los;
  stay;
  stayc;
  reasonmig ;reason for migration. reason 1 = ...
  ru ; rural or urban. rural = 1 and urban = 2
  gender ; migrant's gender. female = 1 male = 2
  originstate ;migrant's state of origin

  hh? ;part of household or not
  hhid ;household ID
  ]

movingmembers-own
[native? ;native or migrant
  age;
  life;
  los;
  stay;
  stayc;
  reasonmig ;reason for migration. reason 1 = ...
  ru ; rural or urban. rural = 1 and urban = 2
  gender ; migrant's gender. female = 1 male = 2
  originstate ;migrant's state of origin

  hh? ;part of household or not
  hhid ;household ID
  ]

newcomers-own

 [native? ;native or migrant
  age ;
  life ;
  los;
  stayc;
  stay
  reasonmig ;reason for migration. reason 1 = ...
  ru ; rural or urban. rural = 1 and urban = 2
  gender ; migrant's gender. female = 1 male = 2
  originstate ;migrant's state of origin

  hh? ;part of household or not
  hhid ;household ID
  income ;hhheads income
  informal? ; household works in informal sector? bulion.
  searching? ; if migrant is searching for new house - set to true when migrant arrives first time or dissatisfied with the place and set to false once found the place
  willing? ; if resident is willing to share the house in face of rising rents
  class-updated? ;temporary variable to make sure that each person's class is updated at the end of each iteration
  old ; to record how long resident has been at this city? ;for further analysis on residential mobility
  ; to record how long resident has been at this site? ;only available for the current residence; for further analysis on residential mobility
  num-houses ;to record how many houses hhheads have changed ;for further analysis on residential mobility
  hhsize ;
  hhsizelimit
  ]

 patches-own
 [occupied? ; occupancy status of a property
  available? ; availablity status of housing units. a patch might be available even if there are occupants if number of units on that patch is higher than current occupancy
  num-hhheads ;number of households on a particular property
  num-occupants ;number of occupants on a particular property
  num-units ; number of possible units if a developer holds the property
  slum-occupants ;number of poor occupants on a particular property
  rent ; economic rent of the property
  rent-payable ; if people start sharing the house, this variable shows the rent that each person is paying on that property (used for people making decision on housing - they are not worreid about the complete rent, they are worried how much they would pay in a shared accomodation)rent payable is lower for poor people if they live in slums (in proportion with how many poor people live there)
  slum? ; if site is squatted set to true otherwise false (shared facilities are shown as squatted - however, sharing also means apartment building on a land-parcel, not differentiated in this model yet)
  resicat ;to record residential category. category 3 if occupied by poor, 2 if by middle-class and 1 if rich (useful to calculate density)
  ward ;to record political ward number of city
 ]

;;END OF SECTION 1. VARIABLE DECLARATION
;***************************************

;;SECTION 2. INITIALIZATION
;**************************
to setup ;initial population and environment setup
  __clear-all-and-reset-ticks ;clear remains of previous runs
    set max-rent 1000 ; to set maximum rent of a land-parcel at the start of simulation
    set min-rent max-rent / initialinequality ; to set minimum rent of a land-parcel at the start of simulation. Calculated based on initial inequality level.
    set lifeexp 62 ;life-expectancy at birth
    set InflatoryIndex 0.15 ;compensate for out-migration (census do not provide those who out-migrated)
    set MigRate AnnualMigrationRate * (1 + InflatoryIndex)

    set n 35
    set k 0
    set m 2 * (lifeexp - n)

    set numreason 7; number of reasons for migration
    set reasonlist [0 1 2 3 4 5 6 7]
    set reasonpr    [0 0.174 0.240 0.249 0.428 0.496 0.74 1.0] ; first zero;reason probability


   ;;CREATE POLITICAL WARDS
   ask patches with [pxcor > -26 and pxcor < -8 and pycor > -26 and pycor < -8] [set ward 1 set pcolor 71 setcommoninitconditionspatches] ;ward 1 - peripheral ward
   ask patches with [pxcor > -9 and pxcor < 9 and pycor > -26 and pycor < -8] [set ward 2 set pcolor 72 setcommoninitconditionspatches] ;ward 2 - peripheral ward
   ask patches with [pxcor > 8 and pxcor < 26 and pycor > -26 and pycor < -8] [set ward 3 set pcolor 73 setcommoninitconditionspatches] ;ward 3 - peripheral ward
   ask patches with [pxcor > -26 and pxcor < -8 and pycor > -9 and pycor < 9] [set ward 4 set pcolor 74 setcommoninitconditionspatches] ;ward 4 - peripheral ward
   ask patches with [pxcor > -9 and pxcor < 9 and pycor > -9 and pycor < 9] [set ward 5 set pcolor 75 setcommoninitconditionspatches] ;ward 5 - central ward
   ask patches with [pxcor > 8 and pxcor < 26 and pycor > -9 and pycor < 9] [set ward 6 set pcolor 76 setcommoninitconditionspatches] ;ward 6 -peripheral ward
   ask patches with [pxcor > -26 and pxcor < -8 and pycor > 8 and pycor < 26] [set ward 7 set pcolor 77 setcommoninitconditionspatches] ;ward 7 - peripheral ward
   ask patches with [pxcor > -9 and pxcor < 9 and pycor > 8 and pycor < 26] [set ward 8 set pcolor 78 setcommoninitconditionspatches] ;ward 8 - peripheral ward
   ask patches with [pxcor > 8 and pxcor < 26 and pycor > 8 and pycor < 26] [set ward 9 set pcolor 79 setcommoninitconditionspatches] ;ward 9 - peripheral ward

   ;;INITIAL LAND PARCEL AND POPULATION CREATION
   ask n-of ((percent-prime-land * count patches with [abs pxcor <= initialcitylimit and abs pycor <= initialcitylimit] / 100) + (percent-inappropriate-land * count patches with [abs pxcor < initialcitylimit and abs pycor < initialcitylimit] / 100)) patches with [abs pxcor < initialcitylimit and abs pycor < initialcitylimit] ;set up patches within user-specified initial city limit
    [ifelse random-float 1 < (percent-prime-land / (percent-prime-land + percent-inappropriate-land)) ;to declare randomly selected patches in the city-center as prime or inadequate land (proportion is user-specified)
      [set rent max-rent set rent-payable rent sprout 1 [setcommoninitconditionshhheads]] ;create initial land parcels with highest-rent
      [set rent min-rent set rent-payable rent sprout 1 [setcommoninitconditionshhheads]]] ;land parcels with lowest-rent
   ask patches with [rent = 0 and abs pxcor <= initialcitylimit and abs pycor <= initialcitylimit]
    [set rent random-float 1 * (max-rent - min-rent) set rent-payable rent sprout 1 [setcommoninitconditionshhheads]] ;patches with rent varying (normally distributed) between highest-rent and lowest-rent

   ask hhheads [update-class update-searching update-willingnesstoshare update-hhmembers update-hhsize] ;Note: update-class requires all agents to be created first so could not be done earlier.

   ask patches [update-occupancy update-availability update-resicat update-slumstatus]


;;INITIATE GLOBAL VARIABLES
set cityincome sum [income] of hhheads
update-variables
end

to setcommoninitconditionspatches ;part of initiation
  set num-units 1 ;to set initial number of housing units per patch. the value changes for some patches as simulation progresses.
  set available? true ;to set initial availability
  set occupied? false ;to set initial occupancy status
  set num-occupants 0 ;to set initial occupancy levels
  set slum-occupants 0 ;to set initial slum occupancy
  set slum? false ;to set initial slum status
end

to setcommoninitconditionshhheads
   set breed hhheads
   set hhid who
   set old 0
   set stay 0

   set num-houses 1
   set income 3.3 * [rent] of patch-here ;initially the incomes are sent in accordance with the housing unit they are occupying. i.e. most prime land occupiers are rich, inadequate land occupiers are poor.
   ifelse random-float 1 < informalityindex [set informal? true][set informal? false]
   set hh? true
   set age random n
   set life n + random m
   set los random-exponential avglos
   set stayc 0
   hatch random 5  [setinitconditionshhmembers]
   ifelse random-float 1 < 0.6 [set native? true][set native? false]
   set class-updated? false
   set hhsizelimit 1 + random 15
   ;reasonmig ;reason for migration. reason 1 = ...
   ;ru ; rural or urban. rural = 1 and urban = 2
   ;gender ; migrant's gender. female = 1 male = 2
   ;originstate ;migrant's state of origin
end

to setinitconditionshhmembers
  set breed hhmembers
  set hh? true
  set hhid [hhid] of myself
  set native? [native?] of myself
  set age random n
  set life n + random m
  set los random-exponential avglos
  set stayc 0

  ;reasonmig ;reason for migration. reason 1 = ...
  ;ru ; rural or urban. rural = 1 and urban = 2
  ;gender ; migrant's gender. female = 1 male = 2
  ;originstate ;migrant's state of origin
end

  ;;RENDER INITIAL RENT AS CHOROPLETH
  to RentMap
     ask patches [recolor-patch]
  end
;;END OF SECTION 2. INITIALIZATION
;*********************************


;; SECTION 3. SIMULATION
;***********************
to Slumulate
  ;POPULATION CREATION FROM DES2ABM
  newbirth
  newmigrants
  settle-hhheads ;to get homes for people who are searching home
  update-hhheads ;update all hhheads at the end of the iteration
  update-patches  ;update all patches at the end of the iteration
  update-developers ;update all developers at the end of the iteration
  update-cityincome
  update-variables ;update all variables at the end of the iteration
  kill-citizens ;
  out-migrate
  update-age
  if ticks > 3 [do-plots] ;to ignore initial burn-in period, we start plotting after 3 time periods.
  if (ticks = SimulationRuntime) [stop] ;to stop at user-specified time period.
  tick
end

 ;PROCEDURES RELATED TO TURTLES (AGENTS)
 ;**************************************
 ;hhheads
 ;**********
 ;CREATE NEW hhheads and hhmembers
 ;; TO CREATE natives
to newbirth
  set nb random-poisson (BirthRate * population / 1000)
  crt nb
  [set breed newcomers hhbirth]
end

to newborndefaults
  set native? true
  set age 0
  set life n + random m
  set los random-exponential avglos
    set stayc 0
  set hh? false
  ;NOT RELEVANT
  ;reasonmig ;reason for migration. reason 1 = ...
  ;ru ; rural or urban. rural = 1 and urban = 2
  ;gender ; migrant's gender. female = 1 male = 2
  ;originstate ;migrant's state of origin
  ;PART OF HHBIRTH
  ;hhid ;household ID
end
;;ASSIGN NEW-BORN TO A HOUSEHOLD START
to hhbirth ;similar to findhh but in this case, hhsizelimit condition is removed.
   move-to patch-at random-pxcor random-pycor
   rt random-float 360 ;all directions
   fd random-float 1 ;one step at a time
   ifelse (not any? hhheads-here)[hhbirth]
   [move-to patch-here ; once found a patch, move here
   set breed hhmembers
   set hh? true ;update search status
   set hhid [who] of one-of hhheads-here
   mergebirth
   ]
end

to mergebirth
  ask hhheads-here with [hhid = [hhid] of myself] [update-hhsizelimit1]
end

to update-hhsizelimit1 ;NO LIMITS IMPOSED ON NEW-BORNS
    set hhsizelimit hhsizelimit + 1
end
;ASSIGN NEW-BORN TO A HOUSEHOLD END

;CREATE NEW MIGRANTS START
to newmigrants
  set nm random-poisson MigRate

  crt nm
    [set breed newcomers
      set hhid -1
     set hh? false
     set native? false
     set age k + random n
    set life n + random m
    set los random-exponential avglos
    set stay 0



    let s random-float 1 ; state of origin starts here
  set y 1
  while [y < (numreason + 1)]
  [if (s < item y reasonpr) and (s > item (y - 1) reasonpr)
    [set reasonmig item y reasonlist]
    set y y + 1
  ]
    ;from HHjoin
    if (reasonmig = 1 or reasonmig = 2 or reasonmig = 3 or reasonmig = 7)[hhheaddefaults]
    if (reasonmig = 6)[set breed hhmembers formhh]
    if (reasonmig = 4 or reasonmig = 5) [findhh]
     ;
    ]
end

to hhheaddefaults
  set breed hhheads
  set hhid who
  set old 0
  set stay 0
  set native? false
  set age k + random n
  set life n + random m
  set num-houses 1
  set income random-exponential avg-income ;assign income to new agent based on current income distribution
  set searching? true
  set num-houses 0
  ifelse random-float 1 < informalityindex [set informal? true][set informal? false]
  ; from DES2ABM
  set hh? true
  set hhsizelimit 1 + random 15
  update-hhsize
  update-class
  update-willingnesstoshare
end

to findhh
   move-to patch-at random-pxcor random-pycor
   rt random-float 360 ;all directions
   fd random-float 10 ;one step at a time
   ifelse (not any? hhheads-here with [hhsize < hhsizelimit])[findhh] ;
   [move-to patch-here ; once found a patch, move here
   set breed hhmembers
   hhmemberdefaults
   set hhid [who] of one-of hhheads-here
   merge
   ]
 end

to merge
  ask hhheads-here with [hhid = [hhid] of myself] [update-hhsize]
end

to formhh
  if any? hhheads-here[
  ask one-of hhheads-here [assign-hhid update-hhsize]]
  die
end


to assign-hhid
  ask hhmembers with [hhid = -1][set hhid [hhid] of myself hhmemberdefaults]
end

to hhmemberdefaults
  set native? false ;native or migrant
  set age k + random n
  set life n + random m

  ;reasonmig ;reason for migration. reason 1 = ...
  ;ru ; rural or urban. rural = 1 and urban = 2
  ;gender ; migrant's gender. female = 1 male = 2
  ;originstate ;migrant's state of origin

  set hh? true ;part of household or not
end

to update-age
  ask hhheads
  [set age age + 1]
  ask hhmembers
  [set age age + 1]
end

to kill-citizens
  set death count hhheads with [age > life] + count hhmembers with [age > life]
  set everdeath everdeath + death
  ask hhheads with [age > life]
    [if hhsize > 1 [updatehhhead]
      die]
  ask hhmembers with [age > life]
    [die]
end

;;OUT-MIGRATION
to out-migrate
  ask hhheads [if stayc > los [die]    ]
  ask hhmembers [if stayc > los [if hhsize > 1 [updatehhhead] die]]
end

 to updatehhsize-1
  ask hhheads-here with [hhid = [hhid] of myself][update-hhsize]
end

;to changehhhead
 ;   ifelse hhsize = 1
  ;  [die]
   ; [updatehhhead die]
;end

to updatehhhead
   ask one-of hhmembers-here with [hhid =[hhid] of myself] [update-household]
end

to update-household
     set breed hhheads
     update-hhsize
     set income [income] of myself
     set informal? [informal?] of myself ;set job-type
     set class-updated? [class-updated?] of myself
     set willing? [willing?] of myself
     set searching? [searching?] of myself
     set old [old] of myself
     set stay [stay] of myself
     set num-houses [num-houses] of myself
     set hhsizelimit [hhsizelimit] of myself - 1

  ;reasonmig ;reason for migration. reason 1 = ...
  ;ru ; rural or urban. rural = 1 and urban = 2
  ;gender ; migrant's gender. female = 1 male = 2
  ;originstate ;migrant's state of origin
  ;hh? ;part of household or not
  ;hhid ;household ID
end



 ;SETTLE hhheads
 to settle-hhheads
   ask hhheads with [searching?]
       [ask hhmembers-here with [hhid = [hhid] of myself] [set breed movingmembers]
         move-to patch 0 0 ; start from center...
         find-house] ;...and then roam around to search a house that is within income-constraints
 end
 ;HOUSE SEARCH PROCESS
 to find-house

   rt random-float 360 ;all directions
   fd random-float 1 ;one step at a time
   if (any? hhheads-here with [color != [color] of myself])
       or (rent-payable > 0.3 * income)
       or (not available?) ;;
        [find-house] ;if rent is higher than a person can pay or already occupied by people who wouldn't want to share, keep searching
   ;from HHMove
   move-to patch-here ; once found a patch, move here
   ;from HHMove
   set target patch-here
    joinme

   set searching? false ;update search status
   set stay 0 ;restart how long household has lived here
   set num-houses (num-houses + 1); number of houses a household has changed after arriving in the city. for further analysis on residential mobility.
   ask patch-here [update-occupancy update-availability update-slumstatus update-resicat update-rent-payable] ; to update the newly occupied patch before the next agent starts the search.
 end

 ;HOUSEHOLDS JOINS MOVED HOUSEHOLD
 to joinme
    ask movingmembers [set breed hhmembers move-to target]
 end


 ;UPDATE hhheads
 to update-hhheads
    ask hhheads [update-income update-willingnesstoshare update-searching update-class update-old update-stay update-hhmembers update-hhsize]
 end
  ;UPDATE INCOME OF hhheads
  to update-income
    if (informal? = true) and (color = red) [set income income + (economicgrowthrate / 100) * 0.1 * income]
    if (informal? = false) and (color = red) [set income income + (economicgrowthrate / 100) * income]
    if (color = green) or (color = blue) [set income income + (economicgrowthrate / 100) * income]
  end
  ;UPDATE WILLINGNESS TO SHARE
  to update-willingnesstoshare
     ifelse rent-payable > ((1 - price-sensitivity) * 0.3 * income)
            [set willing? true]
            [set willing? false]
     if (color = green or color = blue) [set willing? false]
  end
  ;UPDATE SEARCH STATUS
  to update-searching
     ifelse rent-payable > (1 + staying-power) * 0.3 * income
        [set searching? true create-developer]
        [set searching? false]
     if (any? other hhheads-here with [color != [color] of myself])
          [set searching? true]
  end
  ;UPDATE INCOME CLASS
  to update-class
     if income > (mean [income] of hhheads + 1.1 * standard-deviation [income] of hhheads) [set color green set class-updated? true update-hhmembers]
     if income < (mean [income] of hhheads - 0.1 * standard-deviation [income] of hhheads) [set color red set class-updated? true update-hhmembers]
     if (income < (mean [income] of hhheads + 1.1 * standard-deviation [income] of hhheads))
        and (income > (mean [income] of hhheads - 0.1 * standard-deviation [income] of hhheads))[set color blue set class-updated? true update-hhmembers]
  end
  ;UPDATE NUMBER OF YEARS STAYED IN THE CITY
  to update-old
     set old (old + 1)
  end
  ;UPDATE NUMBER OF YEARS STAYED IN THIS PLACE
  to update-stay
    set stay (stay + 1)
  end
  ;UPDATE RENT CHOROPLETH
  to recolor-patch  ; patch procedure -use color to indicate rent level
     set pcolor scale-color yellow rent lowestrent highestrent
     if (slum? = true) [set pcolor grey]
  end
 ;DEVELOPERS
 ;**********
 to create-developer
   ask hhheads-here
       [if not any? developers-here
             and not any? other hhheads-here
             and Develop = true
             [
               hatch 1
               [
                 set breed developers set no-role? false set num-units num-units + int random-float 3 set available? true set resicat 0
                 ]
               ]
       ]
 end
 to update-hhmembers
   if hhsize > 1 [
   ask hhmembers-here with [hhid =[hhid] of myself] [set color [color] of myself]]
 end

 to update-hhsize
   set hhsize 1 + count hhmembers-here with [hhid = [hhid] of myself]
 end

 to update-developers
    ask developers [check-no-role? exit]
 end
  ;CHECK ROLE
  to check-no-role?
     ask developers [if (num-units = num-occupants)[set no-role? true]]
     ask developers [if (num-units < num-occupants)[set no-role? true]]
  end
  ;EXIT
  to exit
     if (no-role? = true) [die]
  end
;;END OF PROCEDURES RELATED TO TURTLES (AGENTS)
;;*********************************************

;;PROCEDURES RELATED TO PATCHES (SPATIAL ENVIRONMENT)
;****************************************************
to update-patches
  diffuse rent diffusion-rate ;neighborhood effect of property prices.
  ask patches [update-rent update-occupancy update-resicat update-slumstatus update-availability update-rent-payable recolor-patch]
end
 ;UPDATE RENT
 to update-rent
    set rent rent + ((0.5 * economicgrowthrate) / 100) * rent
 end
 ;UPDATE OCCUPANCY LEVEL AND OCCUPANCY STATUS
 to update-occupancy
    set num-hhheads count hhheads-here ;number of occupants sharing the property
    ifelse num-hhheads > 0 [set occupied? true][set occupied? false]
    set num-occupants count hhheads-here + count hhmembers-here
 end
 ;UPDATE RESIDENTIAL CATEGORY
 to update-resicat
    if num-hhheads > num-units [set resicat 4]
    if (any? hhheads-here with [color = red]) and (slum? = false) [set resicat 3]
    if (any? hhheads-here with [color = blue]) and (slum? = false) [set resicat 2]
    if (any? hhheads-here with [color = green])and (slum? = false)[set resicat 1]
    if num-occupants = 0 [set resicat 0]
 end
 ;UPDATE SLUM STATUS
 to update-slumstatus
   if num-hhheads > num-units [set slum? true set slum-occupants num-occupants]
   if num-hhheads < num-units [set slum? false set slum-occupants 0]
   if num-hhheads = num-units [set slum? false set slum-occupants 0]
 end
 ;UPDATE AVAILABILITY
 to update-availability
    if (any? developers-here)
    [
     if num-occupants < num-units [set available? true]
     if num-occupants = num-units [set available? false]
     ]

    if (not any? developers-here)
    [
      ifelse num-occupants > 0
             [if (any? hhheads-here with [willing? = false]) [set available? false]]  ; to declare a land parcel as occupied (and hence not available for people searching home)
             [set occupied? false set available? true]
     ] ;otherwise show property as available
 end
 ;UPDATE RENT PAYABLE PER UNIT
 to update-rent-payable
  if (any? developers-here) [set rent-payable (rent / num-units)]
  if (not any? developers-here)
  [
    if not slum? [set rent-payable rent / num-units]
    if slum?
      [
        set rent-payable rent / num-occupants
         if (Politics = true)
          [
           if (ward = 1) [set rent-payable ((1 - ward1slumpoppercent) * (rent-payable))]
           if (ward = 2) [set rent-payable ((1 - ward2slumpoppercent) * (rent-payable))]
           if (ward = 3) [set rent-payable ((1 - ward3slumpoppercent) * (rent-payable))]
           if (ward = 4) [set rent-payable ((1 - ward4slumpoppercent) * (rent-payable))]
           if (ward = 5) [set rent-payable ((1 - ward5slumpoppercent) * (rent-payable))]
           if (ward = 6) [set rent-payable ((1 - ward6slumpoppercent) * (rent-payable))]
           if (ward = 7) [set rent-payable ((1 - ward7slumpoppercent) * (rent-payable))]
           if (ward = 8) [set rent-payable ((1 - ward8slumpoppercent) * (rent-payable))]
           if (ward = 9) [set rent-payable ((1 - ward9slumpoppercent) * (rent-payable))]
           ]
       ]
   ]
end
;;END OF PROCEDURES RELATED TO PATCHES (SPATIAL ENVIRONMENT)
;***********************************************************

;;GLOBAL VARIABLES UPDATE
;************************
to update-variables
   set red-count count hhheads with [color = red] + count hhmembers with [color = red]
   set green-count count hhheads with [color = green] + count hhmembers with [color = green]
   set blue-count count hhheads with [color = blue] + count hhmembers with [color = blue]

   set red-density red-count / (count patches with [resicat = 3])
   set blue-density blue-count / (count patches with [resicat = 2])
   set green-density green-count / (count patches with [resicat = 1])
   set avg-density (count hhheads + count hhmembers) / (count patches with [occupied? = true])

   set red-averagerent mean [rent-payable] of hhheads with [color = red] ;to keep track of rents during simulation in this developing stage. no analytical interest.
   set green-averagerent mean [rent-payable] of hhheads with [color = green] ;to keep track of rents during simulation in this developing stage. no analytical interest.
   set blue-averagerent mean [rent-payable] of hhheads with [color = blue] ;to keep track of rents during simulation in this developing stage. no analytical interest.
   set highestrent max [rent] of patches ;to calculate highest rent in the city
   set lowestrent min [rent] of patches ;to calculate lowerst rent in the city

   set num-searching (count hhheads with [searching?])

   set population (count hhheads + count hhmembers) ;total population of the city

   set avg-income-red mean [income] of hhheads with [color = red]
   set avg-income-green mean [income] of hhheads with [color = green]
   set avg-income-blue mean [income] of hhheads with [color = blue]
   set avg-income cityincome / population

   set slumpop sum [slum-occupants] of patches ;total slum  population of the city
   set centralslumpop sum [slum-occupants] of patches with [ward = 5]
   set peripheralslumpop sum [slum-occupants] of patches with [ward != 5]
   set slumpoppercent (slumpop / population)
   set num-slums count patches with [slum? = true]; count number of slum patches
   set central-num-slums count patches with [slum? = true and ward = 5]
   set peripheral-num-slums count patches with [slum? = true and ward != 5]
   set slumareapercent (num-slums / count patches with [occupied? = true]) * 100
   set centralslumareapercent (count patches with [slum? = true and ward = 5] / count patches with [occupied? = true and ward = 5]) * 100
   if count patches with [occupied? = true and ward != 5] > 0
   [set peripheryslumareapercent (count patches with [slum? = true and ward != 5] / count patches with [occupied? = true and ward != 5]) * 100]

   if num-slums > 0 [set slum-density slumpop / num-slums] ;slum density

   if num-slums > 0 [set smallest-slum min [slum-occupants] of patches with [slum? = true]]
   if num-slums > 0 [set largest-slum min [slum-occupants] of patches with [slum? = true]]


   if central-num-slums > 0 [set central-slum-density centralslumpop / central-num-slums]
   if peripheral-num-slums > 0 [set periphery-slum-density peripheralslumpop / peripheral-num-slums]


   set num-developers (count developers) ;keep track of properties held by developers

   set ward1pop sum [num-occupants] of patches with [ward = 1] ;ward-wise population
   set ward2pop sum [num-occupants] of patches with [ward = 2]
   set ward3pop sum [num-occupants] of patches with [ward = 3]
   set ward4pop sum [num-occupants] of patches with [ward = 4]
   set ward5pop sum [num-occupants] of patches with [ward = 5]
   set ward6pop sum [num-occupants] of patches with [ward = 6]
   set ward7pop sum [num-occupants] of patches with [ward = 7]
   set ward8pop sum [num-occupants] of patches with [ward = 8]
   set ward9pop sum [num-occupants] of patches with [ward = 9] ;ward-wise poulation ends

   set ward1slumpop sum [slum-occupants] of patches with [ward = 1];ward-wise slum population
   set ward2slumpop sum [slum-occupants] of patches with [ward = 2]
   set ward3slumpop sum [slum-occupants] of patches with [ward = 3]
   set ward4slumpop sum [slum-occupants] of patches with [ward = 4]
   set ward5slumpop sum [slum-occupants] of patches with [ward = 5]
   set ward6slumpop sum [slum-occupants] of patches with [ward = 6]
   set ward7slumpop sum [slum-occupants] of patches with [ward = 7]
   set ward8slumpop sum [slum-occupants] of patches with [ward = 8]
   set ward9slumpop sum [slum-occupants] of patches with [ward = 9];ward-wise slum poulation ends

   if ward1pop > 0 [set ward1slumpoppercent ward1slumpop / ward1pop] ;ward 1 slum population in percent (0 to 1)
   if ward2pop > 0 [set ward2slumpoppercent ward2slumpop / ward2pop];ward 2 slum population in percent
   if ward3pop > 0 [set ward3slumpoppercent ward3slumpop / ward3pop];ward 3 slum population in percent
   if ward4pop > 0 [set ward4slumpoppercent ward4slumpop / ward4pop];ward 4 slum population in percent
   if ward5pop > 0 [set ward5slumpoppercent ward5slumpop / ward5pop];ward 5 slum population in percent
   if ward6pop > 0 [set ward6slumpoppercent ward6slumpop / ward6pop];ward 6 slum population in percent
   if ward7pop > 0 [set ward7slumpoppercent ward7slumpop / ward7pop];ward 7 slum population in percent
   if ward8pop > 0 [set ward8slumpoppercent ward8slumpop / ward8pop];ward 8 slum population in percent
   if ward9pop > 0 [set ward9slumpoppercent ward9slumpop / ward9pop];ward 9 slum population in percent

   set centralslumpoppercent (ward5slumpoppercent) * 100
   if (sum [num-occupants] of patches with [ward != 5] > 0 )
      [set peripheryslumpoppercent (sum [slum-occupants] of patches with [ward != 5]) / (sum [num-occupants] of patches with [ward != 5]) * 100]

if population > 0 [
  set deathrate death / (population / 1000)]
  set migrantpop count hhheads with [native? = false] + count hhmembers with [native? = true]
  set nativepop count hhheads with [native? = true] + count hhmembers with [native? = false]
end


;;UPDATE CITY INCOME
to update-cityincome
  set cityincome cityincome + (economicgrowthrate / 100) * cityincome
end
;; UPDATE PLOTS
;**************
to do-plots
  set-current-plot "Housing Density"
  set-current-plot-pen "Lower Income Group"
  plot red-density
  set-current-plot-pen "Middle Income Group"
  plot blue-density
  set-current-plot-pen "Higher Income Group"
  plot green-density
  set-current-plot-pen "Slums"
  plot slum-density
  set-current-plot "Slum Size Distribution"
  set-current-plot-pen "Slum Size"
  histogram [slum-occupants] of patches with [slum? = true]
  set-current-plot "% Slum Population"
  set-current-plot-pen "City"
  plot slumpop / population * 100
  set-current-plot-pen "Central"
  plot centralslumpoppercent
  set-current-plot-pen "Periphery"
  plot peripheryslumpoppercent
end
;; END OF SECTION 3. SIMULATION
;******************************
;;END OF PROGRAM
;;**************
@#$#@#$#@
GRAPHICS-WINDOW
242
10
724
493
-1
-1
9.3
1
10
1
1
1
0
1
1
1
-25
25
-25
25
1
1
1
Years
30.0

BUTTON
6
10
76
43
Initiate
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

BUTTON
149
10
238
43
Slumulate!
Slumulate
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
731
517
808
562
LIG Population
red-count
3
1
11

MONITOR
889
517
968
562
HIG Population
green-count
3
1
11

SLIDER
5
304
238
337
percent-prime-land
percent-prime-land
0
40
10.0
1
1
percent
HORIZONTAL

SLIDER
5
338
238
371
percent-inappropriate-land
percent-inappropriate-land
0
40
10.0
1
1
percent
HORIZONTAL

MONITOR
809
517
888
562
MIG Population
blue-count
0
1
11

MONITOR
729
197
807
242
LIG Density
red-density
2
1
11

MONITOR
887
197
964
242
HIG Density
green-density
2
1
11

MONITOR
808
197
885
242
MIG Density
blue-density
2
1
11

PLOT
729
10
1060
196
Housing Density
Time
Density
0.0
5.0
0.0
5.0
true
true
"" ""
PENS
"Lower Income Group" 1.0 0 -2674135 true "" ""
"Middle Income Group" 1.0 0 -13345367 true "" ""
"Higher Income Group" 1.0 0 -10899396 true "" ""
"Slums" 1.0 0 -7500403 true "" ""

SLIDER
5
236
237
269
diffusion-rate
diffusion-rate
0
0.25
0.03
0.01
1
NIL
HORIZONTAL

SLIDER
5
406
238
439
price-sensitivity
price-sensitivity
0
1
0.1
0.1
1
NIL
HORIZONTAL

SLIDER
5
440
238
473
staying-power
staying-power
0
1
0.3
0.1
1
NIL
HORIZONTAL

SLIDER
5
372
238
405
informalityindex
informalityindex
0
1
0.7
0.1
1
NIL
HORIZONTAL

SLIDER
5
270
237
303
economicgrowthrate
economicgrowthrate
0
5
2.0
0.1
1
Percent
HORIZONTAL

MONITOR
729
331
826
376
Slum Population
slumpop
0
1
11

BUTTON
78
10
147
43
RentMap
RentMap
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
729
377
826
422
% Slum Population
slumpop / population * 100
1
1
11

INPUTBOX
99
45
239
112
SimulationRuntime
50.0
1
0
Number

SWITCH
6
45
96
78
Politics
Politics
0
1
-1000

SWITCH
6
79
96
112
Develop
Develop
0
1
-1000

MONITOR
729
285
826
330
No of Slums
num-slums
17
1
11

MONITOR
965
197
1059
242
Slum Density
slum-density
2
1
11

MONITOR
830
377
927
422
% Slum Population
centralslumpoppercent
1
1
11

MONITOR
931
377
1028
422
% Slum Population
peripheryslumpoppercent
1
1
11

MONITOR
830
285
927
330
No of Slums
central-num-slums
0
1
11

MONITOR
931
285
1028
330
No of Slums
peripheral-num-slums
0
1
11

MONITOR
830
331
927
376
Slum Population
centralslumpop
0
1
11

MONITOR
931
331
1028
376
Slum Population
peripheralslumpop
0
1
11

MONITOR
830
423
927
468
Slum Density
centralslumpop / central-num-slums
1
1
11

MONITOR
931
424
1029
469
Slum Density
peripheralslumpop / peripheral-num-slums
1
1
11

MONITOR
729
424
826
469
Slum Density
slum-density
1
1
11

TEXTBOX
762
270
809
288
City
11
0.0
1

TEXTBOX
849
266
907
288
Central City
11
0.0
1

TEXTBOX
955
270
1011
288
Periphery
11
0.0
1

TEXTBOX
888
250
1167
268
Slum Conditions in Center vs. Periphery
13
0.0
1

PLOT
1058
10
1226
196
Slum Size Distribution
Size
No. of Slums
2.0
30.0
0.0
10.0
true
true
"" ""
PENS
"Slum Size" 1.0 1 -7500403 false "" ""

MONITOR
729
470
826
515
% Slum Area
(num-slums / count patches with [occupied? = true]) * 100
1
1
11

MONITOR
1060
196
1149
241
Smallest Slum
min [slum-occupants] of patches with [slum? = true]
0
1
11

MONITOR
1151
196
1226
241
Largest Slum
max [slum-occupants] of patches with [slum? = true]
0
1
11

MONITOR
830
469
927
514
% Slum Area
(count patches with [slum? = true and ward = 5] / count patches with [occupied? = true and ward = 5]) * 100
1
1
11

MONITOR
931
470
1029
515
% Slum Area
(count patches with [slum? = true and ward != 5] / count patches with [occupied? = true and ward != 5]) * 100
1
1
11

PLOT
1030
285
1226
513
% Slum Population
Time
% Slum Population
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"City" 1.0 0 -7500403 true "" ""
"Central" 1.0 0 -2674135 true "" ""
"Periphery" 1.0 0 -13345367 true "" ""

SLIDER
5
474
238
507
initialcitylimit
initialcitylimit
5
15
10.0
1
1
NIL
HORIZONTAL

SLIDER
5
509
237
542
initialinequality
initialinequality
1
20
10.0
1
1
NIL
HORIZONTAL

INPUTBOX
122
113
238
173
AnnualMigrationRate
40.0
1
0
Number

INPUTBOX
6
113
117
173
BirthRate
23.0
1
0
Number

MONITOR
969
516
1029
561
Population
population
0
1
11

INPUTBOX
120
174
235
234
avglos
30.0
1
0
Number

INPUTBOX
6
174
118
234
lifeexp
62.0
1
0
Number

@#$#@#$#@
## WHAT IS IT?

Slumulation is a model to understand slum formation in cities. Income-inequalities coupled with market prices driven by a few high-income group drives majority of new migrants to either occupy an inappropriate land for habitat or illegally share the housing. Hihger density in slums on the face of rising land prices is explained.

We furhter add the politics of slums. Two primary actors, developers and local politicians are added. Spatial scale at which politicans operate is an electorate ward. Model explains how voting power adds to political cost of eviction and hence makes certain sites unavailable for formal development despite being prime locations.

## HOW TO USE IT

Each pass through the Slumulate function represents a year in the time scale of this model.

The POPGROWTHRATE slider sets the monthly population growth rate.

The PERCENT-PRIME-LAND slider sets the percentage prime land in the city core.  The model is initialized to have a total number of rich households equal to number of prime land parcels.

The PERCENT-INAPPROPRIATE-LAND slider sets the percentage inadequate land in the city core. The model is initialized to have a total number of poor households equal to number of inappropriate land parcels.

The DIFFUSION-RATE slider sets how fast the price diffusion occurs in the landscape. Higher the diffusion-rate, faster the price diffuses.

The PRICE-SENSITIVITY slider determines how early a turtle 'senses' approaching prices that it can not afford whereas STAYING-POWER slider determines how long a turtle can stay before it actively starts searching for a new location that it can afford. Together they provide shorter or longer 'window of period' to find partners to share the facility.

The INFORMAL-FORMAL-ECONOMY slider determines if informal sector is growing or formal sector is growing. if informal sector is growing, it increases income of low-income households proportionately more compared to high-income families. Conversely when formal economy is growing, it makes rich households rich faster than it increases income of poor households. When formal economy is growing, housing prices also rise more than when informal economy is growing.

The GDP display the sum of the incomes of all households in the city. POPULATION display the total number of households in the city.

LIG POPULATION, MIG POPULATION and HIG POPULATION  monitors display the number of lower-income households ,middle-income households and higher-income households respectively.

The LIG-DENSITY MIG-DENSITY, HIG-DENSITY and SLUM-DENSITY monitors dispay the density of housing for LIG, MIg,HIG and SLUMS respectively.

HOUSING DENSITY plots the housing density for slums and different income-groups over simulation time.

SLUM SIZE DISTRIBUTION plots the histogram of slum size.

NO. OF SLUMS, SLUM POPULATION, % SLUM POPULATION, SLUM DENSITY, % SLUM AREA is displayed for the overall city, central city and peripheral parts of the city.

The SLUMULATE! button runs the model.  A running plot is also displayed of the red-density, blue-density and green-density over time.

The SIMULATIONRUNTIME stops the simulation at the specified number of ticks in that box.


## THINGS TO NOTICE

How does different percent of prime land affects density of slums?

Does the formal growth rate give rise to higher densities of slums  (less affordable hosuing for poor)?

Does the poor always end up with slums?

## THINGS TO TRY

Try running different experiments with different values on sliders and see if poor remain in formal housing?

## EXTENDING THE MODEL

Extension with introduction of more active political and developer agents with an ability to bid for specific sites for eviction or retention.

## CREDITS AND REFERENCES

To refer to this model in academic publications, please use:  Patel, A. Crooks, A. Koizumi, A (2012). Slumulation Netlogo Model, George Mason Univerity, USA.
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
  <experiment name="Urbanization" repetitions="100" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="AnnualMigrationRate">
      <value value="20"/>
      <value value="30"/>
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informalityindex">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="EconomicGrowth" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informal-formal-economy">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
      <value value="3.5"/>
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="PrimeLand" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
      <value value="20"/>
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informal-formal-economy">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="No Center Search (Old)" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informal-formal-economy">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Typical Run" repetitions="30" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informalityindex">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Central Search Off" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informalityindex">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Politics and Development ON OFF" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informalityindex">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Population Growth Rate" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>Slumulate</go>
    <metric>slumpoppercent</metric>
    <metric>centralslumpoppercent</metric>
    <metric>peripheryslumpoppercent</metric>
    <metric>num-slums</metric>
    <metric>central-num-slums</metric>
    <metric>peripheral-num-slums</metric>
    <metric>slumareapercent</metric>
    <metric>centralslumareapercent</metric>
    <metric>peripheryslumareapercent</metric>
    <metric>slum-density</metric>
    <metric>central-slum-density</metric>
    <metric>periphery-slum-density</metric>
    <metric>red-density</metric>
    <metric>blue-density</metric>
    <metric>green-density</metric>
    <metric>smallest-slum</metric>
    <metric>largest-slum</metric>
    <enumeratedValueSet variable="staying-power">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-inappropriate-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="informalityindex">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="percent-prime-land">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialcitylimit">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="popgrowthrate">
      <value value="2"/>
      <value value="3"/>
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="SimulationRuntime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Politics">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Develop">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-sensitivity">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="diffusion-rate">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="economicgrowthrate">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialinequality">
      <value value="10"/>
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
