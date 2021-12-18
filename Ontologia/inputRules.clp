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


(defrule PreguntasAlSolicitant
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
        (bind (?pPreuMax 100000)) ;;preu indiferent
        (bind (?pPreuMaxFlexible 100000)) ;;preu indiferent
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
        (bind (?preuMin 0)) ;;preu indiferent
        (bind (?preuMinFlexible 0)) ;;preu indiferent
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
                  (bind ?llistaPositivaDebil (insert$ (?llargada + 1) (nth$ 2 ?pServei)))
                else
                  (bind ?llargada (length$ ?llistaPositivaForta))
                  (bind ?llistaPositivaForta (insert$ (?llargada + 1) (nth$ 2 ?pServei)))
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
                (bind ?llistaNegativaDebil (insert$ (?llargada + 1) (nth$ 2 ?pServei)))
              else
                (bind ?llargada (length$ ?llistaNegativaForta))
                (bind ?llistaNegativaForta (insert$ (?llargada + 1) (nth$ 2 ?pServei)))
            )
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
        (preuMaxim ?pPreuMax)
        (preuMaxFlexible ?pPreuMaxFlexible)
        (preuMinim ?preuMin)
        (preuMinimFlexible ?preuMinFlexible)
        (superficieMax)
        (superficieMaxFlex)
        (superficieMinim)
        (superficieMinimFlex)
        (garatge)
        (balco)
        (mascota)
        (llistaServeiPositiva ?llistaPositiu)
        (llistaServeiNegativa ?llistaNegativa)
        (llistaServeiPositivaDebil ?llistaPositivaDebil)
        (llistaServeiNegativaDebil ?llistaNegativaDebil)
        (llistaServeiPositivaForta ?llistaPositivaForta)
        (llistaServeiNegativaForta ?llistaNegativaForta)
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
      (bind ?acceptable (comprovarVivenda ?curr-obj ?carSolicitant))
      (if ?acceptable
        then
          (puntuarVivendes ?carSolicitant ?curr-obj)
      )
  )
  (retract ?trigger)
  (retract ?carSolicitant)
  (assert (mostrar_resultats))
)


(defrule iibuscaPossibles
    ?trigger <- (cercargjhg)
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
