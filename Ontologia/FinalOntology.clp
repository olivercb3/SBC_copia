;;; ---------------------------------------------------------
;;; Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/FinalOntology.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/FinalOntology.owl
;;; :Date 14/12/2021 11:09:22

(defclass Localitat
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot esta_a_prop
        (type INSTANCE)
        (create-accessor read-write))
    (slot coordX
        (type INTEGER)
        (create-accessor read-write))
    (slot coordY
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
    (slot te_car_vivenda
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

(defclass Caracteristiques
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot aire_condicionat
        (type SYMBOL)
        (create-accessor read-write))
    (slot balco
        (type SYMBOL)
        (create-accessor read-write))
    (slot calefaccio
        (type SYMBOL)
        (create-accessor read-write))
    (slot electrodomestics
        (type SYMBOL)
        (create-accessor read-write))
    (slot garatge
        (type SYMBOL)
        (create-accessor read-write))
    (slot mascota
        (type SYMBOL)
        (create-accessor read-write))
    (slot moblada
        (type SYMBOL)
        (create-accessor read-write))
    (slot num_dormitoris
        (type INTEGER)
        (create-accessor read-write))
    (slot piscina
        (type SYMBOL)
        (create-accessor read-write))
    (slot planta
        (type INTEGER)
        (create-accessor read-write))
    (slot solejat
        (type SYMBOL)
        (create-accessor read-write))
    (slot terrassa
        (type SYMBOL)
        (create-accessor read-write))
    (slot vivenda_amb_vistes
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
    (slot cotxe
        (type SYMBOL)
        (create-accessor read-write))
    (slot num_membres_grup
        (type INTEGER)
        (create-accessor read-write))
    (slot pref_transport_public
        (type SYMBOL)
        (create-accessor read-write))
    (slot preu_solicitant
        (type INTEGER)
        (create-accessor read-write))
    (slot superficie_solicitant
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Car_Vivenda
    (is-a Caracteristiques)
    (role concrete)
    (pattern-match reactive)
    (slot preu
        (type INTEGER)
        (create-accessor read-write))
    (slot superficie
        (type INTEGER)
        (create-accessor read-write))
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
    (slot te_car_solicitant
        (type INSTANCE)
        (create-accessor read-write))
    (slot edat
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
    ([Bar_Castelo] of Oci
         (coordX  10)
         (coordY  3)
    )

    ([Bar_Gracia] of Oci
         (coordX  10)
         (coordY  8)
    )

    ([Bar_Los_Pepes] of Oci
         (coordX  3)
         (coordY  8)
    )

    ([Bus_1] of TransportPublic
         (coordX  12)
         (coordY  12)
    )

    ([Bus_2] of TransportPublic
         (coordX  15)
         (coordY  4)
    )

    ([Bus_3] of TransportPublic
         (coordX  15)
         (coordY  6)
    )

    ([CarVivenda_0] of Car_Vivenda
         (preu  500)
         (superficie  59)
         (aire_condicionat  "true")
         (balco  "true")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "true")
         (mascota  "false")
         (moblada  "true")
         (num_dormitoris  3)
         (piscina  "true")
         (planta  1)
         (solejat  "true")
         (terrassa  "true")
         (vivenda_amb_vistes  "true")
    )

    ([CarVivenda_1] of Car_Vivenda
         (preu  800)
         (superficie  65)
         (aire_condicionat  "false")
         (balco  "true")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "true")
         (mascota  "false")
         (moblada  "true")
         (num_dormitoris  2)
         (piscina  "true")
         (planta  2)
         (solejat  "true")
         (terrassa  "true")
         (vivenda_amb_vistes  "true")
    )

    ([CarVivenda_2] of Car_Vivenda
         (preu  750)
         (superficie  70)
         (aire_condicionat  "true")
         (balco  "false")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "false")
         (mascota  "false")
         (moblada  "false")
         (num_dormitoris  2)
         (piscina  "false")
         (planta  2)
         (solejat  "false")
         (terrassa  "false")
         (vivenda_amb_vistes  "false")
    )

    ([CarVivenda_3] of Car_Vivenda
         (preu  1500)
         (superficie  150)
         (aire_condicionat  "true")
         (balco  "true")
         (calefaccio  "false")
         (electrodomestics  "true")
         (garatge  "true")
         (mascota  "true")
         (moblada  "true")
         (num_dormitoris  1)
         (piscina  "false")
         (planta  0)
         (solejat  "true")
         (terrassa  "false")
         (vivenda_amb_vistes  "false")
    )

    ([CarVivenda_4] of Car_Vivenda
         (preu  1000)
         (superficie  120)
         (aire_condicionat  "false")
         (balco  "true")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "true")
         (mascota  "true")
         (moblada  "false")
         (num_dormitoris  3)
         (piscina  "false")
         (planta  0)
         (solejat  "true")
         (terrassa  "false")
         (vivenda_amb_vistes  "false")
    )

    ([CarVivenda_5] of Car_Vivenda
         (preu  1200)
         (superficie  80)
         (aire_condicionat  "true")
         (balco  "true")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "false")
         (mascota  "true")
         (moblada  "false")
         (num_dormitoris  2)
         (piscina  "false")
         (planta  4)
         (solejat  "false")
         (terrassa  "false")
         (vivenda_amb_vistes  "true")
    )

    ([CarVivenda_6] of Car_Vivenda
         (preu  650)
         (superficie  70)
         (aire_condicionat  "true")
         (balco  "false")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "false")
         (mascota  "true")
         (moblada  "false")
         (num_dormitoris  3)
         (piscina  "false")
         (planta  4)
         (solejat  "true")
         (terrassa  "false")
         (vivenda_amb_vistes  "true")
    )

    ([CarVivenda_7] of Car_Vivenda
         (preu  580)
         (superficie  55)
         (aire_condicionat  "true")
         (balco  "true")
         (calefaccio  "true")
         (electrodomestics  "true")
         (garatge  "true")
         (mascota  "false")
         (moblada  "true")
         (num_dormitoris  4)
         (piscina  "false")
         (planta  2)
         (solejat  "true")
         (terrassa  "false")
         (vivenda_amb_vistes  "false")
    )

    ([CarVivenda_8] of Car_Vivenda
         (preu  900)
         (superficie  90)
         (aire_condicionat  "false")
         (balco  "false")
         (calefaccio  "false")
         (electrodomestics  "true")
         (garatge  "true")
         (mascota  "true")
         (moblada  "true")
         (num_dormitoris  2)
         (piscina  "false")
         (planta  2)
         (solejat  "false")
         (terrassa  "false")
         (vivenda_amb_vistes  "false")
    )

    ([CarVivenda_9] of Car_Vivenda
         (preu  820)
         (superficie  78)
         (aire_condicionat  "true")
         (balco  "false")
         (calefaccio  "true")
         (electrodomestics  "false")
         (garatge  "false")
         (mascota  "true")
         (moblada  "true")
         (num_dormitoris  3)
         (piscina  "false")
         (planta  3)
         (solejat  "true")
         (terrassa  "false")
         (vivenda_amb_vistes  "true")
    )

    ([Escola_Miravet] of Escoles
         (coordX  7)
         (coordY  12)
    )

    ([Escola_Santa_Cristina] of Escoles
         (coordX  12)
         (coordY  9)
    )

    ([Hospital_Grenda] of CentreSalud
         (coordX  3)
         (coordY  8)
    )

    ([Parc_Fermi] of ZonesVerdes
         (coordX  16)
         (coordY  13)
    )

    ([Parc_Ginesta] of ZonesVerdes
         (coordX  9)
         (coordY  14)
    )

    ([Parc_Miranda] of ZonesVerdes
         (coordX  9)
         (coordY  4)
    )

    ([Tren_4] of TransportPublic
         (coordX  10)
         (coordY  9)
    )

    ([Vivenda_0] of Pis
         (te_car_vivenda  [CarVivenda_0])
    )

    ([Vivenda_1] of Pis
         (te_car_vivenda  [CarVivenda_1])
    )

    ([Vivenda_2] of Pis
         (te_car_vivenda  [CarVivenda_2])
    )

    ([Vivenda_3] of Unifamiliar
         (te_car_vivenda  [CarVivenda_3])
    )

    ([Vivenda_4] of Unifamiliar
         (te_car_vivenda  [CarVivenda_4])
    )

    ([Vivenda_5] of Duplex
         (te_car_vivenda  [CarVivenda_5])
    )

    ([Vivenda_6] of Duplex
         (te_car_vivenda  [CarVivenda_6])
    )

    ([Vivenda_7] of Pis
         (te_car_vivenda  [CarVivenda_7])
    )

    ([Vivenda_8] of Pis
         (te_car_vivenda  [CarVivenda_8])
    )

    ([Vivenda_9] of Pis
         (te_car_vivenda  [CarVivenda_9])
    )

    ([Cinema_Del_Mar] of Oci
         (coordX  8)
         (coordY  6)
    )

    ([Discoteca_Sirena] of Oci
         (coordX  8)
         (coordY  8)
    )

    ([Hospital_Sant_Pau] of CentreSalud
         (coordX  17)
         (coordY  6)
    )

    ([Lidl_1] of Hipermercats
         (coordX  7)
         (coordY  2)
    )

    ([Mercadona_1] of SuperMercats
         (coordX  14)
         (coordY  11)
    )

    ([Mercadona_2] of SuperMercats
         (coordX  5)
         (coordY  8)
    )

    ([Metro_1] of TransportPublic
         (coordX  2)
         (coordY  14)
    )

    ([Metro_2] of TransportPublic
         (coordX  4)
         (coordY  12)
    )

    ([Metro_3] of TransportPublic
         (coordX  6)
         (coordY  10)
    )

    ([Metro_4] of TransportPublic
         (coordX  7)
         (coordY  8)
    )

    ([Metro_5] of TransportPublic
         (coordX  8)
         (coordY  4)
    )

    ([Restaurant_Masia] of Oci
         (coordX  9)
         (coordY  8)
    )

    ([Tren_1] of TransportPublic
         (coordX  18)
         (coordY  2)
    )

    ([Tren_2] of TransportPublic
         (coordX  15)
         (coordY  14)
    )

    ([Tren_3] of TransportPublic
         (coordX  5)
         (coordY  2)
    )

)
