(deffunction acceptableInteger ?valor ?min ?max
  ( return ( or (> ?valor ?max) (< ?valor ?min)) )
)

(deffunction acceptableSingleInteger ?valor ?esperat
  ( return ( eq ?valor ?esperat ))
)

(deffunction acceptableServei ?valorSol ?serveiViv
    (switch ?valorSol
        (case oci (return (object (is-a Oci))))
        (case zonesverdes (return (object (is-a ZonesVerdes))))
        (case centresalut (return (object (is-a CentreSalut))))
        (case transportpublic (return (object (is-a TransportPublic))))
        (case escoles (return (object (is-a Escoles))))
        (case supermercats (return (object (is-a SuperMercats))))
        (case hipermercats (return (object (is-a Hipermercats))))
    )
)

(deffunction acceptableBinari ?valorSol ?valorVivenda
    (switch ?valorSol
        (case 0 (return TRUE))
        (case 1 (return TRUE))
        (case 2 (return (?valorVivenda)))
        (case -1 (return TRUE))
        (case -2 (return (not (?valorVivenda))))
    )
)

(deffunction comprovarVivenda ?vivenda ?solicitud

    (bind ?res TRUE)

    (bind ?c (send ?vivenda get-te_car_vivenda))


    ;;preu
    (bind ?preu (send ?c get-preu))
    (bind ?res (acceptableInteger ?preu ?preuMax ?preuMin))
    (if (not ?res)
      then return FALSE
    )

    ;;superficie
    (bind ?superficie (send ?c get-superficie))
    (bind ?res (acceptableInteger ?superficie ?superficieMax ?superficieMin))
    (if (not ?res)
      then return FALSE
    )

    ;;numhab
    (bind ?numHab (send ?c get-num_dormitoris))
    (bind ?res (acceptableSingleInteger ?numHab ?solNumHab))
    (if (not ?res)
      then return FALSE
    )


    ;;mascota
    (bind ?mascota (send ?c get-mascota))
    (bind ?res (acceptableBinari ?solMascota ?mascota))
    (if (not ?res)
      then return FALSE
    )

    ;;balco
    (bind ?mascota (send ?c get-balco))
    (bind ?res (acceptableBinari ?solBalco ?balco))
    (if (not ?res)
      then return FALSE
    )

    ;;garatge
    (bind ?mascota (send ?c get-garatge))
    (bind ?res (acceptableBinari ?solGaratge ?garatge))
    (if (not ?res)
      then return FALSE
    )

    ;;Serveis Positius
    (bind $?serveis (send ?vivenda get-esta_a_prop))
    (loop-for-count (?i 1 (length$ $?llistaPositivaForta))
        (bind ?curr-servei (nth$ ?i ?llistaPositivaForta))
        (bind ?found FALSE)
        (loop-for-count (?i 1 (length$ $?serveis))
            (bind ?serveiViv (nth$ ?i ?serveis))
            (bind ?found (acceptableServei ?curr-servei ?serveiViv))
            (if ?found then (break))
        )
        ;;s'ha trobat el servei?
        (if (not ?found)
          then return FALSE
        )
    )

    ;;Serveis Negatius
    (loop-for-count (?i 1 (length$ $?llistaServeiNegativaForta))
        (bind ?curr-servei (nth$ ?i ?llistaServeiNegativaForta))
        (bind ?found FALSE)
        (loop-for-count (?i 1 (length$ $?serveis))
            (bind ?serveiViv (nth$ ?i ?serveis))
            (bind ?found (acceptableServei ?curr-servei ?serveiViv))
            (if ?found then (break))
        )
        ;;s'ha trobat el servei?
        (if ?found)
          then return FALSE
        )
    )





)
