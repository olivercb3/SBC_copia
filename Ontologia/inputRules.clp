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
  (slot llistaServeiPositiva)
  (slot llistaServeiNegativa)
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


(defrule PreguntasAlSolicitant
    ?trigger <- (preguntar)
    =>

    (bind ?valorsPermesosBinari (create$ "segur si" "si" "indiferent" "no" "segur no"))
    (bind ?valorsPermesosServei (create$ "centresalut" "escoles" "hipermercats" "supermercats" "oci" "transportpublic" "zonesverdes"))
    (bind ?valorsPermesosFlexible (create$ "si" "no" "indiferent"))

    ;;Preguntar preu max
    (bind ?pFlexible (preguntaFlexible "Ets flexible en el preu?" ?valorsPermesosFlexible))   ;;retorna 1 si es flexible, -1 si no es flexible, 0 si el preu li es indiferent

    (if (neq ?pFlexible 0)
      then (bind ?pPreuMax (preguntaInteger "Quin és el teu pressupost?" 1 10000))
            (bind ?pPreuMax (preguntaInteger "A partir de quin preu minim consideraries la oferta viable?" 0 ?pPreuMax))
      else
        (bind (?pPreu 100000))
    )

    (bind ?llistaPositiu (create$))
    (bind ?llistaNegativa (create$))

    (while TRUE
      do
        (bind ?pServei (preguntaServeisPositiva "Necessites algun servei a prop?" ?valorsPermesosServei))
        (if (eq (nth$ 1 ?pServei) 0)
          then (break)
          else
              (bind ?llargada (length$ ?llistaPositiu))
              (bind ?llistaPositiu (insert$ (?llargada + 1) (nth$ 1 ?pServei)))
              (bind ?llistaPositiu (insert$ (?llargada + 2) (nth$ 2 ?pServei)))
        )
    )

    (while TRUE
      do
        (bind ?pServei (preguntaServeisNegativa "No vols algun servei a prop?" ?valorsPermesosServei))
        (if (eq (nth$ 1 ?pServei) 0)
          then (break)
          else
              (bind ?llargada (length$ ?llistaNegativa))
              (bind ?llistaNegativa (insert$ (?llargada + 1) (nth$ 1 ?pServei)))
              (bind ?llistaNegativa (insert$ (?llargada + 2) (nth$ 2 ?pServei)))
        )
    )

    ;; "segur seguit d'un servei ..."

    (retract ?trigger)

    (assert (car_solicitant
        (edat)
        (fills)
        (personesGrans)
        (numHab)
        (habFlexible)
        (preuMaxim)
        (preuMaxFlexible)
        (preuMinim)
        (preuMinimFlexible)
        (superficieMax)
        (superficieMaxFlex)
        (superficieMinim)
        (superficieMinimFlex)
        (garatge)
        (balco)
        (mascota)
        (llistaServeiPositiva ?llistaPositiu)
        (llistaServeiNegativa ?llistaNegativa)
      )
    )
    (assert (cercar))
)

(defrule buscarPossibles
  ?carSolicitant <- ...
  ?trigger <- (cercar)
  =>
  (printout t crlf)
  (printout t "...Buscant vivendes..." crlf)
  (printout t crlf)

  (bind $?vivendes (find-all-instances ((?ins Vivenda)) TRUE))
  (loop-for-count (?i 1 (length$ $?vivendes))
    do
      (bind ?curr-obj (nth$ ?i ?vivendes))
      (bind ?c (send ?curr-obj get-te_car_vivenda))

      (bind ?puntuacio 0)

      (bind ?llistadolenta (create$))
      (bind ?llistabona (create$))

      (bind ?curr-preu (send ?c get-preu))

      ;;filtrar per restriccions fortes
  )
)


(defrule buscaPossibles
    ?trigger <- (cercar)
    =>
    (bind ?pPreu (send [CarInput] get-preu_solicitant))
    (bind ?pBalco (send [CarInput] get-balco))
    (bind ?pGaratge (send [CarInput] get-garatge))

    (printout t crlf)
  	(printout t "...Buscant vivendes..." crlf)
  	(printout t crlf)

    ;;Possibles vivendes

    (bind $?vivendes (find-all-instances ((?ins Vivenda)) TRUE))
    (bind ?n (length$ (find-all-instances ((?ins Car_Vivenda)) TRUE)))
    ;;(printout t "Hi ha " ?n " vivendes" crlf)
    (loop-for-count (?i 1 (length$ $?vivendes)) do

	;;La instancia de vivenda que tractarem
        ;;(printout t "Vivenda nº " ?i ": " crlf)
	(bind ?curr-obj (nth$ ?i ?vivendes))

        (bind ?c (send ?curr-obj get-te_car_vivenda))
        (bind ?curr-preu (send ?c get-preu))
        (bind ?curr-balco (if (eq (send ?c get-balco) "TRUE") then TRUE else FALSE))
	(bind ?curr-garatge (if (eq (send ?c get-garatge) "TRUE") then TRUE else FALSE))

        (if (and (<= ?curr-preu ?pPreu) (eq ?curr-balco ?pBalco) (eq ?curr-garatge ?pGaratge))
          then (printVivenda ?curr-obj)
	  else (printout t "La vivenda " ?curr-obj " no satisfa les teves especificacions" crlf)
        )

    )
    (retract ?trigger)
)
