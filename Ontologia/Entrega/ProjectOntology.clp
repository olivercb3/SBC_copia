;;; ---------------------------------------------------------
;;; Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/ProjectOntologyAprop.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/ProjectOntologyAprop.owl
;;; :Date 14/12/2021 11:08:43

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

(defclass CentreSalut
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
    (slot ascensor
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
         (aire_condicionat  TRUE)
         (balco  TRUE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  TRUE)
         (mascota  FALSE)
         (moblada  TRUE)
         (num_dormitoris  3)
         (piscina  TRUE)
         (planta  1)
         (solejat  TRUE)
         (terrassa  TRUE)
         (ascensor  TRUE)
         (vivenda_amb_vistes  TRUE)
    )

    ([CarVivenda_1] of Car_Vivenda
         (preu  800)
         (superficie  65)
         (aire_condicionat  FALSE)
         (balco  TRUE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  TRUE)
         (mascota  FALSE)
         (moblada  TRUE)
         (num_dormitoris  2)
         (piscina  TRUE)
         (planta  2)
         (solejat  TRUE)
         (terrassa  TRUE)
         (ascensor  TRUE)
         (vivenda_amb_vistes  TRUE)
    )

    ([CarVivenda_2] of Car_Vivenda
         (preu  750)
         (superficie  70)
         (aire_condicionat  TRUE)
         (balco  FALSE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  FALSE)
         (mascota  FALSE)
         (moblada  FALSE)
         (num_dormitoris  2)
         (piscina  FALSE)
         (planta  2)
         (solejat  FALSE)
         (terrassa  FALSE)
         (ascensor  FALSE)
         (vivenda_amb_vistes  FALSE)
    )

    ([CarVivenda_3] of Car_Vivenda
         (preu  1500)
         (superficie  150)
         (aire_condicionat  TRUE)
         (balco  TRUE)
         (calefaccio  FALSE)
         (electrodomestics  TRUE)
         (garatge  TRUE)
         (mascota  TRUE)
         (moblada  TRUE)
         (num_dormitoris  1)
         (piscina  FALSE)
         (planta  0)
         (solejat  TRUE)
         (terrassa  FALSE)
         (ascensor  TRUE)
         (vivenda_amb_vistes  FALSE)
    )

    ([CarVivenda_4] of Car_Vivenda
         (preu  1000)
         (superficie  120)
         (aire_condicionat  FALSE)
         (balco  TRUE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  TRUE)
         (mascota  TRUE)
         (moblada  FALSE)
         (num_dormitoris  3)
         (piscina  FALSE)
         (planta  0)
         (solejat  TRUE)
         (terrassa  FALSE)
         (ascensor  TRUE)
         (vivenda_amb_vistes  FALSE)
    )

    ([CarVivenda_5] of Car_Vivenda
         (preu  1200)
         (superficie  80)
         (aire_condicionat  TRUE)
         (balco  TRUE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  FALSE)
         (mascota  TRUE)
         (moblada  FALSE)
         (num_dormitoris  2)
         (piscina  FALSE)
         (planta  4)
         (solejat  FALSE)
         (terrassa  FALSE)
         (ascensor  FALSE)
         (vivenda_amb_vistes  TRUE)
    )

    ([CarVivenda_6] of Car_Vivenda
         (preu  650)
         (superficie  70)
         (aire_condicionat  TRUE)
         (balco  FALSE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  FALSE)
         (mascota  TRUE)
         (moblada  FALSE)
         (num_dormitoris  3)
         (piscina  FALSE)
         (planta  4)
         (solejat  TRUE)
         (terrassa  FALSE)
         (ascensor  FALSE)
         (vivenda_amb_vistes  TRUE)
    )

    ([CarVivenda_7] of Car_Vivenda
         (preu  580)
         (superficie  55)
         (aire_condicionat  TRUE)
         (balco  TRUE)
         (calefaccio  TRUE)
         (electrodomestics  TRUE)
         (garatge  TRUE)
         (mascota  FALSE)
         (moblada  TRUE)
         (num_dormitoris  4)
         (piscina  FALSE)
         (planta  2)
         (solejat  TRUE)
         (terrassa  FALSE)
         (ascensor  TRUE)
         (vivenda_amb_vistes  FALSE)
    )

    ([CarVivenda_8] of Car_Vivenda
         (preu  900)
         (superficie  90)
         (aire_condicionat  FALSE)
         (balco  FALSE)
         (calefaccio  FALSE)
         (electrodomestics  TRUE)
         (garatge  TRUE)
         (mascota  TRUE)
         (moblada  TRUE)
         (num_dormitoris  2)
         (piscina  FALSE)
         (planta  2)
         (solejat  FALSE)
         (terrassa  FALSE)
         (ascensor  FALSE)
         (vivenda_amb_vistes  FALSE)
    )

    ([CarVivenda_9] of Car_Vivenda
         (preu  820)
         (superficie  78)
         (aire_condicionat  TRUE)
         (balco  FALSE)
         (calefaccio  TRUE)
         (electrodomestics  FALSE)
         (garatge  FALSE)
         (mascota  TRUE)
         (moblada  TRUE)
         (num_dormitoris  3)
         (piscina  FALSE)
         (planta  3)
         (solejat  TRUE)
         (terrassa  FALSE)
         (ascensor  TRUE)
         (vivenda_amb_vistes  TRUE)
    )

    ([Escola_Miravet] of Escoles
         (coordX  7)
         (coordY  12)
    )

    ([Escola_Santa_Cristina] of Escoles
         (coordX  11)
         (coordY  8)
    )

    ([Hospital_Grenda] of CentreSalut
         (coordX  3)
         (coordY  8)
    )

    ([Parc_Ebre] of ZonesVerdes
         (coordX  5)
         (coordY  3)
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
         (esta_a_prop  [Bar_Gracia] [Escola_Santa_Cristina] [Parc_Miranda] [Tren_4] [Cinema_Del_Mar] [Discoteca_Sirena] [Metro_4] [Restaurant_Masia])
    )

    ([Vivenda_1] of Pis
         (te_car_vivenda  [CarVivenda_1])
         (esta_a_prop  [Bar_Gracia] [Escola_Santa_Cristina] [Tren_4] [Cinema_Del_Mar] [Discoteca_Sirena] [Metro_4] [Restaurant_Masia])
    )

    ([Vivenda_2] of Pis
         (te_car_vivenda  [CarVivenda_2])
         (esta_a_prop  [Bus_3] [Hospital_Sant_Pau])
    )

    ([Vivenda_3] of Unifamiliar
         (te_car_vivenda  [CarVivenda_3])
         (esta_a_prop  [Metro_1] [Metro_2])
    )

    ([Vivenda_4] of Unifamiliar
         (te_car_vivenda  [CarVivenda_4])
         (esta_a_prop  [Bus_1] [Parc_Ginesta])
    )

    ([Vivenda_5] of Duplex
         (te_car_vivenda  [CarVivenda_5])
         (esta_a_prop  [Bus_1] [Parc_Ginesta])
    )

    ([Vivenda_6] of Duplex
         (te_car_vivenda  [CarVivenda_6])
         (esta_a_prop  [Bar_Castelo] [Parc_Miranda] [Metro_5])
    )

    ([Vivenda_7] of Pis
         (te_car_vivenda  [CarVivenda_7])
         (esta_a_prop  [Bar_Los_Pepes] [Hospital_Grenda] [Mercadona_2] [Metro_4])
    )

    ([Vivenda_8] of Pis
         (te_car_vivenda  [CarVivenda_8])
         (esta_a_prop  [Parc_Ebre] [Lidl_1] [Tren_3])
    )

    ([Vivenda_9] of Pis
         (te_car_vivenda  [CarVivenda_9])
         (esta_a_prop  [Parc_Fermi] [Mercadona_1])
    )

    ([Cinema_Del_Mar] of Oci
         (coordX  8)
         (coordY  6)
    )

    ([Discoteca_Sirena] of Oci
         (coordX  8)
         (coordY  8)
    )

    ([Hospital_Sant_Pau] of CentreSalut
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
