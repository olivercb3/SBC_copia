(defrule FirstRule
   ?s <- (object (is-a Car_Solicitant)
                 (preu_solicitant ?preuS)
                 )
   ?v <- (object (is-a Car_Vivenda)
                 (preu ?preuV)
                 )
   =>
   (printout t "Solicitant preu" crlf)
   (printout t " " ?preuS " " crlf)
   (printout t "Vivenda preu" crlf)
   (printout t " "?preuV " " crlf)
   (if (< ?preuV ?preuS) then
      (printout t "Acceptable Range" crlf)
   )

   )

(defrule PrintSolicitants
    ?s <- (object (is-a Solicitant) )
    =>
    (printout t "Solicitant: " crlf)
    (printout t (instance-name ?s) crlf)
    (printout t  (send ?s get-edat) crlf)
    (bind ?cars (send ?s get-te_car_solicitant))
    (foreach ?c $?cars
        (bind ?preu (send ?c get-preu_solicitant))
        (bind ?balco (send ?c get-balco))
        (printout t "preu_solictant: "   ?preu crlf)
        (printout t "balco: "   ?balco crlf))
)
