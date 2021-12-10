;;template per les Caracteristiques dels solicitants.
(deftemplate CarSolicitant
    (slot preu (type INTEGER))
	  (slot garatge (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
    (slot balco (type SYMBOL) (allowed-values FALSE TRUE) (default FALSE))
)

(defrule main "Main"
  ;;hauria de ser amb initial-fact pero no sabem com es fa
  ?trigger <- (initial-main)
	=>
	(printout t crlf)
	(printout t "----------- Prototip Inicial ------------" crlf)
	(assert (preguntar))
)


(defrule PreguntasAlSolicitant
    ?trigger <- (preguntar)
    =>
    ;;Preguntar preu
    (bind ?pPreu (preguntaInteger "Quin és el teu pressupost?" 0 10000))

    ;;Pregunta si vols balco
    (bind ?pBalco (preguntaBinaria "Vols Balco?"))

    ;;Preguntar garatge
    (bind ?pGaratge FALSE)
    (bind ?pCotxe (preguntaBinaria "Tens cotxe?"))
    (if (eq ?pCotxe TRUE)
      then (bind ?pGaratge (preguntaBinaria "Necessites tenir un garatge?"))
    )

    (retract ?trigger)

    ;;(assert (sPreu ?pPreu))
    ;;(assert (sBalco ?pBalco))
    ;;(assert (cerca))

    (assert (CarSolicitant
      (preu ?pPreu)
      (balco ?pBalco)
      (garatge ?pGaratge)
      )
    )
    (assert (cercar))
)

(defrule buscaPossibles
    ?CarSolicitant <- (CarSolicitant
      (preu ?pPreu)
      (balco ?pBalco)
      (garatge ?pGaratge)
    )

    ?trigger <- (cercar)
    =>
    (printout t crlf)
  	(printout t "...Buscant vivendes..." crlf)
  	(printout t crlf)

    ;;Possibles Viviendas

    (bind $?viviendas (find-all-instances ((?ins Vivenda)) TRUE))
    (bind ?n (length$ (find-all-instances ((?ins Car_Vivenda)) TRUE)))
    (printout t "Hi ha " ?n " vivendes" crlf)
    (loop-for-count (?i 1 (length$ $?viviendas)) do

		    ;;La instancia de vivenda que tractarem
        ;;(printout t "Vivenda nº " ?i ": " crlf)
		    (bind ?curr-obj (nth$ ?i ?viviendas))

        (bind ?c (send ?curr-obj get-te_car_vivenda))
        (bind ?curr-preu (send ?c get-preu))
        (bind ?teBalco (send ?c get-balco))

        (if (<= ?curr-preu ?pPreu)
          then
          (if (eq ?pBalco TRUE)
            then
            (if (eq ?teBalco TRUE)
              then (printVivenda ?curr-obj))
            else
            (if (eq ?teBalco FALSE)
              then (printVivenda ?curr-obj))
          )
        )

    )
    (retract ?trigger)
)
