(deftemplate car_solicitant
  (slot edat (type INTEGER))
  (slot fills (type INTEGER))
  (slot personesGrans (type INTEGER))
  (slot numHab (type INTEGER))
  (slot habFlexible (type INTEGER))
  (slot preuMaxim (type INTEGER))
  (slot preuMaxFlexible (type INTEGER))
  (slot preuMinim (type INTEGER))   ;debil
  (slot preuMinimFlexible (type INTEGER))
  (slot superficieMax (type INTEGER))
  (slot superficieMaxFlex (type INTEGER))
  (slot superficieMinim (type INTEGER))
  (slot superficieMinimFlex (type INTEGER))
  (slot garatge (type INTEGER))
  (slot balco (type INTEGER))
  (slot mascota (type INTEGER))
  (multislot llistaServeiPositivaDebil)
  (multislot llistaServeiNegativaDebil)
  (multislot llistaServeiPositivaForta)
  (multislot llistaServeiNegativaForta)
)

(defrule main "Main"
  ;hauria de ser amb initial-fact pero no sabem com es fa
  ?trigger <- (initial-main)
	=>
	(reset)
	(printout t crlf)
	(printout t "----------- Prototip Inicial ------------" crlf)
	(assert (preguntar))
)


(defrule PreguntesSolicitant
    ?trigger <- (preguntar)
    =>

    (bind ?valorsPermesosBinari (create$ "segur si" "si" "indiferent" "no" "segur no"))
    (bind ?valorsPermesosServei (create$ "centresalut" "escoles" "hipermercats" "supermercats" "oci" "transportpublic" "zonesverdes"))
    (bind ?valorsPermesosFlexible (create$ "si" "no" "indiferent"))

    (bind ?pEdat (preguntaIntegerUnbound "Quina edat tens?"))
    (bind ?pFills (preguntaIntegerUnbound "Quants fills tens o planeges tenir en un futur proper?"))
    (bind ?pGrans (preguntaIntegerUnbound "Quantes persones grans tens al teu carrec?"))

    ;Preguntar preu max
    (bind ?pFlexible (preguntaFlexible "Ets flexible amb el preu maxim?" ?valorsPermesosFlexible))   ;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?pPreuMax (preguntaInteger "Quin és el teu pressupost maxim?" 1 10000))
            (if (eq ?pFlexible 1)
                then (bind ?pPreuMaxFlexible ( round (* ?pPreuMax 1.2)) )
                else (bind ?pPreuMaxFlexible ?pPreuMax )
            )

      else
        (bind ?pPreuMax 10000) ;preu indiferent
        (bind ?pPreuMaxFlexible 10000) ;preu indiferent
    )

    ;Preguntar preu minim
    (bind ?pFlexible (preguntaFlexible "Ets flexible amb el preu minim?" ?valorsPermesosFlexible))   ;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?pPreuMin (preguntaInteger "Quin és el teu pressupost minim?" 0 ?pPreuMax))
            (if (eq ?pFlexible 1)
                then (bind ?pPreuMinFlexible ( round (* ?pPreuMin 0.8)) )
                else (bind ?pPreuMinFlexible ?pPreuMin )
            )
      else
        (bind ?pPreuMin 0) ;preu indiferent
        (bind ?pPreuMinFlexible 0) ;preu indiferent
    )

    ;Preguntar superficie max
    (bind ?pFlexible (preguntaFlexible "Ets flexible amb la superficie maxima?" ?valorsPermesosFlexible))   ;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?pSupMax (preguntaInteger "Quin és el maxim de superficie que vols?" 15 1000))
            (if (eq ?pFlexible 1)
                then (bind ?pSupMaxFlexible ( round (* ?pSupMax 1.3)) )
                else (bind ?pSupMaxFlexible ?pSupMax )
            )

      else
        (bind ?pSupMax 1000) ;superficie indiferent
        (bind ?pSupMaxFlexible 1000) ;superficie indiferent
    )

    ;Preguntar superficie minim
    (bind ?pFlexible (preguntaFlexible "Ets flexible amb la superficie minima?" ?valorsPermesosFlexible))   ;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?pSupMin (preguntaInteger "Quin és el minim de superficie que vols?" 0 ?pSupMax))
            (if (eq ?pFlexible 1)
                then (bind ?pSupMinFlexible ( round (* ?pSupMin 0.7)) )
                else (bind ?pSupMinFlexible ?pSupMin )
            )
      else
        (bind ?pSupMin 15) ;superficie indiferent
        (bind ?pSupMinFlexible 15) ;superficie indiferent
    )

    (bind ?llistaPositivaForta (create$))
    (bind ?llistaPositivaDebil (create$))
    (bind ?llistaNegativaForta (create$))
    (bind ?llistaNegativaDebil (create$))

    (while TRUE
      do
        (bind ?pServei (preguntaServeisPositiva "Necessites algun servei a prop?" ?valorsPermesosServei))
        (if (eq (nth$ 1 ?pServei) 0)
          then (break)
          else
              (if (eq (nth$ 1 ?pServei) 1)
                then
                  (bind ?llargada (length$ ?llistaPositivaDebil))
                  (bind ?llistaPositivaDebil (insert$ ?llistaPositivaDebil (+ ?llargada 1) (nth$ 2 ?pServei)))
                else
                  (bind ?llargada (length$ ?llistaPositivaForta))
                  (bind ?llistaPositivaForta (insert$ ?llistaPositivaForta (+ ?llargada 1) (nth$ 2 ?pServei)))
              )
        )
    )

    (while TRUE
      do
        (bind ?pServei (preguntaServeisNegativa "No vols algun servei a prop?" ?valorsPermesosServei))
        (if (eq (nth$ 1 ?pServei) 0)
          then (break)
          else
            (if (eq (nth$ 1 ?pServei) -1)
              then
                (bind ?llargada (length$ ?llistaNegativaDebil))
                (bind ?llistaNegativaDebil (insert$ ?llistaNegativaDebil (+ ?llargada 1) (nth$ 2 ?pServei)))
              else
                (bind ?llargada (length$ ?llistaNegativaForta))
                (bind ?llistaNegativaForta (insert$ ?llistaNegativaForta (+ ?llargada 1) (nth$ 2 ?pServei)))
            )
        )
    )

    ; "segur seguit d'un servei ..."

    (retract ?trigger)

    (assert (car_solicitant
        (edat ?pEdat)
        (fills ?pFills)
        (personesGrans ?pGrans)
        (numHab 0)
        (habFlexible 0)
        (preuMaxim ?pPreuMax)
        (preuMaxFlexible ?pPreuMaxFlexible)
        (preuMinim ?pPreuMin)
        (preuMinimFlexible ?pPreuMinFlexible)
        (superficieMax ?pSupMax)
        (superficieMaxFlex ?pSupMaxFlexible)
        (superficieMinim ?pSupMin)
        (superficieMinimFlex ?pSupMinFlexible)
        (garatge 0)
        (balco 0)
        (mascota 0)
        (llistaServeiPositivaDebil ?llistaPositivaDebil)
        (llistaServeiNegativaDebil ?llistaNegativaDebil)
        (llistaServeiPositivaForta ?llistaPositivaForta)
        (llistaServeiNegativaForta ?llistaNegativaForta)
      )
    )
    (assert (cercar))
)

(defrule buscarPossibles
  ?carSolicitant <- (car_solicitant
        (edat ?edat)
        (fills ?fills)
        (personesGrans ?personesGrans)
        (numHab ?numhab)
        (habFlexible ?habflex)
        (preuMaxim ?pPreuMax)
        (preuMaxFlexible ?pPreuMaxFlex)
        (preuMinim ?pPreuMin)
        (preuMinimFlexible ?pPreuMinFlex)
        (superficieMax ?pSupMax)
        (superficieMaxFlex ?pSupMaxFlex)
        (superficieMinim ?pSupMin)
        (superficieMinimFlex ?pSupMinFlex)
        (garatge ?pGaratge)
        (balco ?pBalco)
        (mascota ?pMascota)
        (llistaServeiPositivaDebil $?llistaPositivaDebil)
        (llistaServeiNegativaDebil $?llistaNegativaDebil)
        (llistaServeiPositivaForta $?llistaPositivaForta)
        (llistaServeiNegativaForta $?llistaNegativaForta)
      )
  ?trigger <- (cercar)
  =>
  (printout t crlf)
  (printout t "...Buscant vivendes..." crlf)
  (printout t crlf)

  (bind $?vivendes (find-all-instances ((?ins Vivenda)) TRUE))
  (loop-for-count (?i 1 (length$ $?vivendes))
    do
      (bind ?curr-obj (nth$ ?i ?vivendes))
      (bind ?acceptable (comprovarVivenda ?curr-obj ?numhab
						    ?pPreuMaxFlex
						    ?pPreuMinFlex
						    ?pSupMaxFlex
						    ?pSupMinFlex
						    ?pGaratge
						    ?pBalco
						    ?pMascota
						    ?llistaPositivaForta
						    ?llistaNegativaForta))
      (if ?acceptable
        then
          (bind ?puntuacioVivenda (puntuarVivenda ?curr-obj ?edat
							    ?fills
							    ?personesGrans
							    ?habflex
							    ?pPreuMax
							    ?pPreuMin
							    ?pSupMax
							    ?pSupMin
							    ?pGaratge
							    ?pBalco
							    ?pMascota
							    ?llistaPositivaDebil
							    ?llistaNegativaDebil))
	  (printout t ?puntuacioVivenda crlf)
          (if (> ?puntuacioVivenda 0) then (printVivenda ?curr-obj))
      )
  )
  (retract ?trigger)
  (retract ?carSolicitant)
  (assert (mostrar_resultats))
)
