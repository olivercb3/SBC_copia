;;; ---------------------------------------------------------
;;; Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/Prototype.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/Prototype.owl
;;; :Date 01/12/2021 10:27:23

(defclass Caracteristiques
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot aire_condicionat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot balco
        (type SYMBOL)
        (create-accessor read-write))
    (multislot calefaccio
        (type SYMBOL)
        (create-accessor read-write))
    (multislot electrodomestics
        (type SYMBOL)
        (create-accessor read-write))
    (multislot garatge
        (type SYMBOL)
        (create-accessor read-write))
    (multislot mascota
        (type SYMBOL)
        (create-accessor read-write))
    (multislot moblada
        (type SYMBOL)
        (create-accessor read-write))
    (multislot num_dormitoris
        (type INTEGER)
        (create-accessor read-write))
    (multislot piscina
        (type SYMBOL)
        (create-accessor read-write))
    (multislot planta
        (type INTEGER)
        (create-accessor read-write))
    (multislot solejat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot terrassa
        (type SYMBOL)
        (create-accessor read-write))
    (multislot vivenda_amb_vistes
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
    (multislot cotxe
        (type SYMBOL)
        (create-accessor read-write))
    (multislot num_membres_grup
        (type INTEGER)
        (create-accessor read-write))
    (multislot pref_transport_public
        (type SYMBOL)
        (create-accessor read-write))
    (multislot preu_solicitant
        (type INTEGER)
        (create-accessor read-write))
    (multislot superficie_solicitant
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Car_Vivenda
    (is-a Caracteristiques)
    (role concrete)
    (pattern-match reactive)
    (multislot preu
        (type INTEGER)
        (create-accessor read-write))
    (multislot superficie
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Localitat
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot esta_a_prop
        (type INSTANCE)
        (create-accessor read-write))
    (multislot coordX
        (type INTEGER)
        (create-accessor read-write))
    (multislot coordY
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
    (multislot te_car_vivenda
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
    (multislot te_car_solicitant
        (type INSTANCE)
        (create-accessor read-write))
    (multislot edat
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

(definstances instances
    (Chabola of Vivenda
    )

    (Joan of Solicitant
         (edat  20)
    )

    (Mansio of Vivenda
    )

    (Maria of Solicitant
         (edat  25)
    )

    (Piset of Vivenda
    )

    (carChabola of Car_Vivenda
         (preu  500)
         (balco  "false")
    )

    (carJoan of Car_Solicitant
         (preu_solicitant  1000)
         (balco  "false")
    )

    (carMansio of Car_Vivenda
         (preu  3200)
         (balco  "true")
    )

    (carMaria of Car_Solicitant
         (preu_solicitant  4000)
         (balco  "true")
    )

    (carPiset of Car_Vivenda
         (preu  1200)
         (balco  "true")
    )

)
