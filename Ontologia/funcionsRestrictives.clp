(deffunction acceptableInteger (?valor ?min ?max)
  ( return ( or (> ?valor ?max) (< ?valor ?min)) )
)

(deffunction acceptableSingleInteger (?valor ?esperat)
  ( return ( eq ?valor ?esperat ))
)

(deffunction acceptableServei (?valorSol ?serveiViv)
    (switch ?valorSol
        (case oci then (eq (type ?serveiViv) Oci))
        (case zonesverdes then (eq (type ?serveiViv) ZonesVerdes))
        (case centresalut then (eq (type ?serveiViv) CentreSalut))
        (case transportpublic then (eq (type ?serveiViv) TransportPublic))
        (case escoles then (eq (type ?serveiViv) Escoles))
        (case supermercats then (eq (type ?serveiViv) SuperMercats))
        (case hipermercats then (eq (type ?serveiViv)g Hipermercats))
    )
)

(deffunction acceptableBinari (?valorSol ?valorVivenda)
    (switch ?valorSol
        (case 0 then TRUE)
        (case 1 then TRUE)
        (case 2 then ?valorVivenda)
        (case -1 then TRUE)
        (case -2 then (not ?valorVivenda))
    )
)

(deffunction comprovarVivenda (?vivenda ?solicitud)

    (bind ?res TRUE)

    (bind ?c (send ?vivenda get-te_car_vivenda))

    ;;preu
    (bind ?preu (send ?c get-preu))
    (bind ?res (acceptableInteger ?preu (send ?solicitud get-preuMaxim) (send ?solicitud get-preuMinim)))
    (if (not ?res)
      then return FALSE
    )

    ;;superficie
    (bind ?superficie (send ?c get-superficie))
    (bind ?res (acceptableInteger ?superficie (send ?solicitud get-superficieMax) (send ?solicitud get-superficieMinim)))
    (if (not ?res)
      then return FALSE
    )

    ;;numhab
    (bind ?numHab (send ?c get-num_dormitoris))
    (bind ?res (acceptableSingleInteger ?numHab (send ?solicitud get-numHab)))
    (if (not ?res)
      then return FALSE
    )


    ;;mascota
    (bind ?mascota (send ?c get-mascota))
    (bind ?res (acceptableBinari (send ?solicitud get-mascota) ?mascota))
    (if (not ?res)
      then return FALSE
    )

    ;;balco
    (bind ?balco (send ?c get-balco))
    (bind ?res (acceptableBinari (send ?solicitud get-balco) ?balco))
    (if (not ?res)
      then return FALSE
    )

    ;;garatge
    (bind ?garatge (send ?c get-garatge))
    (bind ?res (acceptableBinari (send ?solicitud get-garatge) ?garatge))
    (if (not ?res)
      then return FALSE
    )

    ;;Serveis Positius
    (bind $?serveis (send ?vivenda get-esta_a_prop))
    (bind $?llistaPositivaForta (send ?solicitud get-llistaServeiPositivaForta))
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
    (bind $?llistaServeiNegativaForta (send ?solicitud get-llistaServeiNegativaForta))
    (loop-for-count (?i 1 (length$ $?llistaServeiNegativaForta))
        (bind ?curr-servei (nth$ ?i ?llistaServeiNegativaForta))
        (bind ?found FALSE)
        (loop-for-count (?i 1 (length$ $?serveis))
            (bind ?serveiViv (nth$ ?i ?serveis))
            (bind ?found (acceptableServei ?curr-servei ?serveiViv))
            (if ?found then (break))
        )
        ;;s'ha trobat el servei?
        (if ?found
          then return FALSE
        )
    )
)
