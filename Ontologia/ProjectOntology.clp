;;; ---------------------------------------------------------
;;; Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/ProjectOntology.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/ProjectOntology.owl
;;; :Date 27/11/2021 03:57:34

(defclass Localitat
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ia-ontologyesta_a_prop
        (type INSTANCE)
        (create-accessor read-write))
    (multislot coordX
        (type SYMBOL)
        (create-accessor read-write))
    (multislot coordY
        (type SYMBOL)
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

(defclass Oci
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass SuperMercats
    (is-a Servei)
    (role concrete)
    (pattern-match reactive)
)

(defclass Hipermercats
    (is-a SuperMercats)
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
    (multislot piscina
        (type SYMBOL)
        (create-accessor read-write))
    (multislot planta
        (type SYMBOL)
        (create-accessor read-write))
    (multislot preu
        (type SYMBOL)
        (create-accessor read-write))
    (multislot solejat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot superficie
        (type SYMBOL)
        (create-accessor read-write))
    (multislot terrassa
        (type SYMBOL)
        (create-accessor read-write))
    (multislot vivenda_amb_vistes
        (type SYMBOL)
        (create-accessor read-write))
    (multislot ia-ontologynum_dormitoris
        (type SYMBOL)
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

(defclass ia-ontologyPersona
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ia-ontologynecessitat_servei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot ia-ontologyno_vol_servei
        (type INSTANCE)
        (create-accessor read-write))
    (multislot ia-ontologypreferencia_servei
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Dependent
    (is-a ia-ontologyPersona)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyFill
    (is-a Dependent)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyPersonaGran
    (is-a Dependent)
    (role concrete)
    (pattern-match reactive)
)

(defclass Solicitant
    (is-a ia-ontologyPersona)
    (role concrete)
    (pattern-match reactive)
    (multislot cotxe
        (type SYMBOL)
        (create-accessor read-write))
    (multislot edat
        (type SYMBOL)
        (create-accessor read-write))
    (multislot mascota
        (type SYMBOL)
        (create-accessor read-write))
    (multislot pref_transport_public
        (type SYMBOL)
        (create-accessor read-write))
    (multislot preu
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass Familia
    (is-a Solicitant)
    (role concrete)
    (pattern-match reactive)
    (multislot ia-ontologya_carrec_de
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
    (multislot ia-ontologynum_membres
        (type SYMBOL)
        (create-accessor read-write))
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
)
