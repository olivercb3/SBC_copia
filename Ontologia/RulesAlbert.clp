(bind ?pEdat (preguntaInteger "Quina es la teva edat?" 0 120))

(bind ?pPreuMax (preguntaInteger "Quin es el teu pressupost maxim?" 0 10000))

(bind ?pPreuMin (preguntaInteger "Tens un preu minim a partir del qual l'oferta es adequada?" 0 10000))

(bind ?pHab (preguntaInteger "Quantes habitacions vols?" 0 50))

;;a afegir dins del loop que recorre les vivendes

(bind ?c (send ?curr-obj get-te_car_vivenda))
(bind ?curr-preu (send ?c get-preu))

(bind ?marge (- ?pPreuMax ?PreuMin))
(bind ?margeNoAdecuat (* ?marge 0.5))
(bind ?margeAdecuat (* ?marge 0.15))

(if  (and (>= ?curr-precio ?pmin) (<= ?curr-precio ?pmax))
  then (printout t "adequat")
  else
  (if (and (>= ?curr-preu (- ?pPreuMin ?margeAdecuat)) (<= ?curr-preu (+ ?pPreuMax ?margeAdecuat)))
    then (prinout t "poc adequat")
    else (if (and (>= ?curr-preu (- ?pPreuMin ?margeNoAdecuat)) (<= ?curr-preu (+ ?pPreuMax ?margeNoAdecuat)))
          then (prinout t "gens adequat")
          else
               (prinout t "basura")
    )
  )
)

;;edat
(if (>= ?pEdat 50))
  then
  ;;ascensor? salut?
  )


;;num habitacions
(bind ?numHab (send ?c get-num_dormitoris))
(if (>= ?numHab ?pHab)
  then (printout t "hab valida")
  else
  (if (< ?numHab ?pHab)
  then (printout t "poc adequat")
  else (prinout t "gens")
  )
)
