;;; ---------------------------------------------------------
;;; Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/ProjectOntology.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology Documents/GitHub/IA-Sistemas-Basados-Conococimiento/Ontologia/ProjectOntology.owl
;;; :Date 27/11/2021 01:16:51

(defclass ia-ontologySolicitant
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyFamilia
    (is-a ia-ontologySolicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyBiparental
    (is-a ia-ontologyFamilia)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyMonoparental
    (is-a ia-ontologyFamilia)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyGrup_estudiants
    (is-a ia-ontologySolicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyIndividual
    (is-a ia-ontologySolicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyParella_fills_proxim
    (is-a ia-ontologySolicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyParella_sense_fills
    (is-a ia-ontologySolicitant)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyLocalitat
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (multislot ia-ontologycoordX
        (type SYMBOL)
        (create-accessor read-write))
    (multislot ia-ontologycoordY
        (type SYMBOL)
        (create-accessor read-write))
)

(defclass ia-ontologyServei
    (is-a ia-ontologyLocalitat)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyCentreSalud
    (is-a ia-ontologyServei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyEscolas
    (is-a ia-ontologyServei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyOci
    (is-a ia-ontologyServei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologySuperMercats
    (is-a ia-ontologyServei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyHipermercats
    (is-a ia-ontologySuperMercats)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyTransportPublic
    (is-a ia-ontologyServei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyZonasVerdes
    (is-a ia-ontologyServei)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyVivenda
    (is-a ia-ontologyLocalitat)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyPis
    (is-a ia-ontologyVivenda)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyduplex
    (is-a ia-ontologyVivenda)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyunifamiliar
    (is-a ia-ontologyVivenda)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyDependent
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyFill
    (is-a ia-ontologyDependent)
    (role concrete)
    (pattern-match reactive)
)

(defclass ia-ontologyPersonaGran
    (is-a ia-ontologyDependent)
    (role concrete)
    (pattern-match reactive)
)

(definstances instances
)
