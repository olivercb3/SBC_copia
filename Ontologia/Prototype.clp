;;; ---------------------------------------------------------
;;; Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/Prototype.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/Prototype.owl
;;; :Date 08/12/2021 02:08:56

(defclass Localitat
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot esta_a_prop
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot coordX
        (type INTEGER)
        (create-accessor read-write))
    (single-slot coordY
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Servei
    (is-a Localitat)
    (role concrete)
    (pattern-match reactive)
)

(defclass CentreSalud
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Escoles
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Mercat
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Hipermercats
    (is-a Mercat)
    (role concrete)
    (pattern-match reactive)
)

(defclass SuperMercats
    (is-a Mercat)
    (role concrete)
    (pattern-match reactive)
)

(defclass Oci
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass TransportPublic
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ZonesVerdes
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Vivenda
    (is-a Localitat)
    (role concrete)
    (pattern-match reactive)
    (single-slot te_car_vivenda
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Duplex
    (is-a Vivenda)
    (role concrete)
    (pattern-match reactive)
)

(defclass Pis
    (is-a Vivenda)
    (role concrete)
    (pattern-match reactive)
)

(defclass Unifamiliar
    (is-a Vivenda)
    (role concrete)
    (pattern-match reactive)
)

(defclass Persona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Dependent
    (is-a Persona)
    (role concrete)
    (pattern-match reactive)
)

(defclass Fill
    (is-a Dependent)
    (role concrete)
    (pattern-match reactive)
)

(defclass PersonaGran
    (is-a Dependent)
    (role concrete)
    (pattern-match reactive)
)

(defclass Solicitant
    (is-a Persona)
    (role concrete)
    (pattern-match reactive)
    (single-slot te_car_solicitant
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot edat
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Familia
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
    (multislot a_carrec_de
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Biparental
    (is-a Familia)
    (role concrete)
    (pattern-match reactive)
)

(defclass Monoparental
    (is-a Familia)
    (role concrete)
    (pattern-match reactive)
)

(defclass Grup_estudiants
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Individual
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Parella_fills_proxim
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Parella_sense_fills
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass Caracteristiques
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (single-slot aire_condicionat
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot balco
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot calefaccio
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot electrodomestics
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot garatge
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot mascota
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot moblada
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot num_dormitoris
        (type INTEGER)
        (create-accessor read-write))
    (single-slot piscina
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot planta
        (type INTEGER)
        (create-accessor read-write))
    (single-slot solejat
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot terrassa
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot vivenda_amb_vistes
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Car_Solicitant
    (is-a Caracteristiques)
    (role concrete)
    (pattern-match reactive)
    (multislot necessitat_servei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot no_vol_servei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot preferencia_no_servei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot preferencia_servei
        (type INSTANCE)
        (create-accessor read-write))
    (single-slot cotxe
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot num_membres_grup
        (type INTEGER)
        (create-accessor read-write))
    (single-slot pref_transport_public
        (type SYMBOL)
        (create-accessor read-write))
    (single-slot preu_solicitant
        (type INTEGER)
        (create-accessor read-write))
    (single-slot superficie_solicitant
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Car_Vivenda
    (is-a Caracteristiques)
    (role concrete)
    (pattern-match reactive)
    (single-slot preu
        (type INTEGER)
        (create-accessor read-write))
    (single-slot superficie
        (type INTEGER)
        (create-accessor read-write))
)

(definstances instances
    ([Chabola] of Vivenda
         (te_car_vivenda  [carChabola])
    )

    ([Joan] of Solicitant
         (te_car_solicitant  [carJoan])
         (edat  25)
    )

    ([Mansio] of Vivenda
         (te_car_vivenda  [carMansio])
         (esta_a_prop  [ia-ontologyHospital])
    )

    ([Maria] of Solicitant
         (te_car_solicitant  [carMaria])
         (edat  80)
    )

    ([Piset] of Vivenda
         (te_car_vivenda  [carPiset])
         (esta_a_prop  [ia-ontologyCinema])
    )

    ([carChabola] of Car_Vivenda
         (preu  500)
         (balco  "false")
    )

    ([carJoan] of Car_Solicitant
         (preu_solicitant  1000)
    )

    ([carMansio] of Car_Vivenda
         (preu  3200)
         (balco  "true")
    )

    ([carMaria] of Car_Solicitant
         (preu_solicitant  4000)
    )

    ([carPiset] of Car_Vivenda
         (preu  900)
         (balco  "true")
    )

    ([ia-ontologyCinema] of Oci
    )

    ([ia-ontologyHospital] of CentreSalud
    )

)
