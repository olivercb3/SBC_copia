(deffunction acceptableInteger (?valor ?min ?max)
  ( return ( or (> ?valor ?max) (< ?valor ?min)) )
)

(deffunction acceptableSingleInteger (?valor ?esperat)
  ( return ( eq ?valor ?esperat ))
)

(deffunction acceptableServei (?valorSol ?serveiViv)
    (switch ?valorSol
        (case oci then return (eq (type ?serveiViv) Oci))
        (case zonesverdes then return (eq (type ?serveiViv) ZonesVerdes))
        (case centresalut then return (eq (type ?serveiViv) CentreSalut))
        (case transportpublic then return (eq (type ?serveiViv) TransportPublic))
        (case escoles then return (eq (type ?serveiViv) Escoles))
        (case supermercats then return (eq (type ?serveiViv) SuperMercats))
        (case hipermercats then return (eq (type ?serveiViv)g Hipermercats))
    )
)

(deffunction acceptableBinari (?valorSol ?valorVivenda)
    (switch ?valorSol
        (case 0 then return TRUE)
        (case 1 then return TRUE)
        (case 2 then return ?valorVivenda)
        (case -1 then return TRUE)
        (case -2 then return (not ?valorVivenda))
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
    (bind $?llistaPositivaDebil (send ?solicitud get-llistaPositivaDebil))
    (loop-for-count (?i 1 (length$ $?llistaPositivaDebil))
        (bind ?curr-servei (nth$ ?i ?llistaPositivaDebil))
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
    (bind $?llistaServeiNegativaDebil (send ?solicitud get-llistaServeiNegativaDebil))
    (loop-for-count (?i 1 (length$ $?llistaServeiNegativaDebil))
        (bind ?curr-servei (nth$ ?i ?llistaServeiNegativaDebil))
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

(deffunction puntuarVivenda (?solicitud ?vivenda)
    (bind ?puntuacio 100)
    (bind ?c (send ?vivenda get-te_car_vivenda))

    ;mirem restriccions fortes

    (bind ?preu (send ?c get-preu))
    (if (and (> ?preu (send ?solicitud get-preuMaxim)) (< ?preu (send ?solicitud get-preuMinim))) then return -100)

    (bind ?superficie (send ?c get-superficie))
    (if (and (> ?superficie (send ?solicitud get-superficieMax)) (< ?superficie (send ?solicitud get-superficieMinim))) then return -100)

    (bind $?serveis (send ?vivenda get-esta_a_prop))

    (bind $?llistaPositivaForta (send ?solicitud get-llistaServeiPositivaForta))
    (loop-for-count (?i 1 (length$ $?llistaPositivaForta))
	(if (not (member$ (nth$ ?i ?llistaPositivaForta) $?serveis)) then return -100)
    )

    (bind $?llistaNegativaForta (send ?solicitud get-llistaServeiNegativaForta))
    (loop-for-count (?i 1 (length$ $?llistaNegativaForta))
	(if (member$ (nth$ ?i ?llistaNegativaForta) $?serveis) then return -100)
    )

    (bind ?balco (send ?c get-balco))
    (bind ?sBalco (send ?solicitud get-balco))
    (if (and (not ?balco) (eq ?sBalco 2)) then return -100)
    (if (and ?balco (eq ?sBalco -2)) then return -100)

    (bind ?garatge (send ?c get-garatge))
    (bind ?sGaratge (send ?solicitud get-garatge))
    (if (and (not ?garatge) (eq ?sGaratge 2)) then return -100)
    (if (and ?garatge (eq ?sGaratge -2)) then return -100)

    (bind ?mascota (send ?c get-mascota))
    (bind ?sMascota (send ?solicitud get-mascota))
    (if (and (not ?mascota) (eq ?sMascota 2)) then return -100)
    (if (and ?mascota (eq ?sMascota -2)) then return -100)
)
