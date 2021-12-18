(deftemplate car_solicitant
  (slot edat (type INTEGER))
  (slot fills (type INTEGER))
  (slot personesGrans (type INTEGER))
  (slot numHab (type INTEGER))
  (slot habFlexible (type INTEGER))
  (slot preuMaxim (type INTEGER))
  (slot preuMaxFlexible (type INTEGER))
  (slot preuMinim (type INTEGER))   ;;debil
  (slot preuMinimFlexible (type INTEGER))
  (slot superficieMax (type INTEGER))
  (slot superficieMaxFlex (type INTEGER))
  (slot superficieMinim (type INTEGER))
  (slot superficieMinimFlex (type INTEGER))
  (slot garatge (type INTEGER))
  (slot balco (type INTEGER))
  (slot mascota (type INTEGER))
  (slot llistaServeiPositivaDebil)
  (slot llistaServeiNegativaDebil)
  (slot llistaServeiPositivaForta)
  (slot llistaServeiNegativaForta)
)

(defrule main "Main"
  ;;hauria de ser amb initial-fact pero no sabem com es fa
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

    ;;Preguntar preu max
    (bind ?pFlexible (preguntaFlexible "Ets flexible en el preu maxim?" ?valorsPermesosFlexible))   ;;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?pPreuMax (preguntaInteger "Quin és el teu pressupost?" 1 10000))
            (if (eq ?pFlexible 1)
                then (bind ?pPreuMaxFlexible ( round (* ?pPreuMax 1.2)) )
                else (bind ?pPreuMaxFlexible ?pPreuMax )
            )

      else
        (bind ?pPreuMax 100000) ;;preu indiferent
        (bind ?pPreuMaxFlexible 100000) ;;preu indiferent
    )

    ;;Preguntar preu minim
    (bind ?pFlexible (preguntaFlexible "Ets flexible en el preu minim?" ?valorsPermesosFlexible))   ;;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?preuMin (preguntaInteger "Quin és el teu pressupost minim?" 0 ?pPreuMax))
            (if (eq ?pFlexible 1)
                then (bind ?preuMinFlexible ( round (* ?preuMin 0.8)) )
                else (bind ?preuMinFlexible ?preuMin )
            )
      else
        (bind ?pPreuMin 0) ;;preu indiferent
        (bind ?pPreuMinFlexible 0) ;;preu indiferent
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

    ;; "segur seguit d'un servei ..."

    (retract ?trigger)

    (assert (car_solicitant
        (edat 0)
        (fills 0)
        (personesGrans 0)
        (numHab 0)
        (habFlexible 0)
        (preuMaxim ?pPreuMax)
        (preuMaxFlexible ?pPreuMaxFlexible)
        (preuMinim ?pPreuMin)
        (preuMinimFlexible ?pPreuMinFlexible)
        (superficieMax 0)
        (superficieMaxFlex 0)
        (superficieMinim 0)
        (superficieMinimFlex 0)
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
        (preuMaxFlexible ?pPreuMaxFlexible)
        (preuMinim ?pPreuMin)
        (preuMinimFlexible ?pPreuMinFlexible)
        (superficieMax ?pSupMax)
        (superficieMaxFlex ?pSupMaxFlex)
        (superficieMinim ?pSupMin)
        (superficieMinimFlex ?pSupMinFlex)
        (garatge ?pGaratge)
        (balco ?pBalco)
        (mascota ?pMascota)
        (llistaServeiPositivaDebil ?llistaPositivaDebil)
        (llistaServeiNegativaDebil ?llistaNegativaDebil)
        (llistaServeiPositivaForta ?llistaPositivaForta)
        (llistaServeiNegativaForta ?llistaNegativaForta)
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
      (bind ?acceptable (comprovarVivenda ?curr-obj ?carSolicitant))
      ;(if ?acceptable
        ;then
          ;(puntuarVivendes ?carSolicitant ?curr-obj)
      ;)
  )
  (retract ?trigger)
  (retract ?carSolicitant)
  (assert (mostrar_resultats))
)
