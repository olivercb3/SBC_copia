(defrule list
   ?s <- (object (is-a Car_Solicitant)
                 (preu_solicitant ?preuS)
                 (instance-name ?nameS)
                 )
   ?v <- (object (is-a Car_Vivenda)
                 (preu ?preuV)
                 (instance-name ?nameV)
                 )
   =>
   (printout t $nameS " " crlf)
   (printout "Possibles Vivendes" crlf)
   (printout t " "?nameV " " crlf)
   (if (< ?preuS ?preuV) then
      (printout t "Acceptable Range" crlf)
   )

   )
