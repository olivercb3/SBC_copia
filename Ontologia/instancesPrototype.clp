(definstances instances
    ([ia-ontologyChabola] of Vivenda
    )

    ([ia-ontologyJoan] of Solicitant
         (edat  20)
    )

    ([ia-ontologyMansio] of Vivenda
    )

    ([ia-ontologyMaria] of Solicitant
         (edat  25)
    )

    ([ia-ontologyPiset] of Vivenda
    )

    ([ia-ontologycarChabola] of Car_Vivenda
         (preu  500)
         (balco  "false")
    )

    ([ia-ontologycarJoan] of Car_Solicitant
         (preu_solicitant  1000)
         (balco  "false")
    )

    ([ia-ontologycarMansio] of Car_Vivenda
         (preu  3200)
         (balco  "true")
    )

    ([ia-ontologycarMaria] of Car_Solicitant
         (preu_solicitant  4000)
         (balco  "true")
    )

    ([ia-ontologycarPiset] of Car_Vivenda
         (preu  1200)
         (balco  "true")
    )

)
