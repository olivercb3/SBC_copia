(defrule main "Main"
  ;;hauria de ser amb initial-fact pero no sabem com es fa
  ?trigger <- (initial-main)
	=>
	(printout t crlf)
	(printout t "--------------------------------------------------------------" crlf)
	(printout t "----------- Sistema de Recomendacion de Viviendas ------------" crlf)
	(printout t "--------------------------------------------------------------" crlf)
	(assert (preguntar))
)


(defrule PreguntasAlSolicitant
    ?trigger <- (preguntar)
    =>
    ;;Pregunta si vols balco
    (bind ?pBalco (preguntaBinaria "Vols Balco?"))
    (if (eq ?pBalco TRUE)
      then (printout t "Vol Balconaco" crlf)
      else (printout t "No vol balco" crlf)
    )
    ;;Preguntar preu
    (bind ?pPreu (preguntaInteger "Dollars?" 0 10000))
    (printout t "El meu preu es " ?pPreu crlf)

    (retract ?trigger)

    ;;(assert (sPreu ?pPreu))
    ;;(assert (sBalco ?pPreu))
    (assert (cerca))
)

(defrule buscaPossibles
    ?trigger <- (cerca)
    =>
    (printout t crlf)
  	(printout t "Buscando viviendas..." crlf)
  	(printout t crlf)
    ;;Possibles Viviendas
    (printout t "Totes les possibles" crlf)
    (bind $?viviendas (find-all-instances ((?ins Vivenda)) TRUE))
    (bind ?n (length$ (find-all-instances ((?ins Car_Vivenda)) TRUE)))
    (printout t "Hi ha nº " ?n " vivendes" crlf)
    (loop-for-count (?i 1 (length$ $?viviendas)) do
		    ;;La instancia de vivienda que vamos a tratar
        (printout t "Vivenda nº " ?i ": " crlf)
		    (bind ?curr-obj (nth$ ?i ?viviendas))
        (printVivenda ?curr-obj)
        )
    (retract ?trigger)
)
