(deffunction acceptableInteger (?valor ?min ?max)
  ( return ( or (> ?valor ?max) (< ?valor ?min)) )
)

(deffunction acceptableSingleInteger (?valor ?esperat)
  ( return (or (eq ?valor 0) (eq ?valor ?esperat )))
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

(deffunction comprovarVivenda (?vivenda ?pnumHab
					?pPreuMax
					?pPreuMin
					?pSupMax
					?pSupMin
					?pgaratge
					?pbalco
					?pmascota
					?pllistaPositivaForta
					?pllistaNegativaForta)

    (bind ?res TRUE)

    (bind ?c (send ?vivenda get-te_car_vivenda))

    ;;preu
    (bind ?preu (send ?c get-preu))
    (bind ?res (acceptableInteger ?preu ?pPreuMax ?pPreuMin))
    (if (not ?res)
	then return FALSE
    )

    ;;superficie
    (bind ?superficie (send ?c get-superficie))
    (bind ?res (acceptableInteger ?superficie ?pSupMax ?pSupMin))
    (if (not ?res)
	then return FALSE
    )

    ;;numhab
    (bind ?numHab (send ?c get-num_dormitoris))
    (bind ?res (acceptableSingleInteger ?pnumHab ?numHab))
    (if (not ?res)
	then return FALSE
    )


    ;;mascota
    (bind ?mascota (send ?c get-mascota))
    (bind ?res (acceptableBinari ?pmascota ?mascota))
    (if (not ?res)
	then return FALSE
    )

    ;;balco
    (bind ?balco (send ?c get-balco))
    (bind ?res (acceptableBinari ?pbalco ?balco))
    (if (not ?res)
	then return FALSE
    )

    ;;garatge
    (bind ?garatge (send ?c get-garatge))
    (bind ?res (acceptableBinari ?pgaratge ?garatge))
    (if (not ?res)
	then return FALSE
    )

    ;;Serveis Positius
    (bind $?serveis (send ?vivenda get-esta_a_prop))
    (loop-for-count (?i 1 (length$ $?pllistaPositivaForta))
        (bind ?curr-servei (nth$ ?i ?pllistaPositivaForta))
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
    (loop-for-count (?i 1 (length$ $?pllistaNegativaForta))
        (bind ?curr-servei (nth$ ?i ?pllistaNegativaForta))
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

    (return TRUE)
)

(deffunction puntuarVivenda (?vivenda ?edat
				      ?fills
				      ?personesGrans
				      ?habflex
				      ?pPreuMaxFlex
				      ?pPreuMinFlex
				      ?pSupMaxFlex
				      ?pSupMinFlex
				      ?pGaratge
				      ?pBalco
				      ?pMascota
				      ?llistaPositivaDebil
				      ?llistaNegativaDebil)
    (bind ?c (send ?vivenda get-te_car_vivenda))

    ;mirem restriccions debils

    (bind ?puntuacio 100)

    (bind ?preu (send ?c get-preu))
    (if (and (> ?preu ?pPreuMaxFlex) (< ?preu ?pPreuMinFlex)) then (bind ?puntuacio (- ?puntuacio 50)))

    (bind ?superficie (send ?c get-superficie))
    (if (and (> ?superficie ?pSupMaxFlex) (< ?superficie ?pSupMinFlex)) then (bind ?puntuacio (- ?puntuacio 50)))

    (bind $?serveis (send ?vivenda get-esta_a_prop))

    (loop-for-count (?i 1 (length$ $?llistaPositivaDebil))
	(if (not (member$ (nth$ ?i ?llistaPositivaDebil) $?serveis)) then (bind ?puntuacio (- ?puntuacio 50)))
	(if (< ?puntuacio 0) then return ?puntuacio)
    )

    (loop-for-count (?i 1 (length$ $?llistaNegativaDebil))
	(if (member$ (nth$ ?i ?llistaNegativaDebil) $?serveis) then (bind ?puntuacio (- ?puntuacio 50)))
	(if (< ?puntuacio 0) then return ?puntuacio)
    )

    (bind ?balco (send ?c get-balco))
    (if (and (not ?balco) (eq ?pBalco 1)) then (bind ?puntuacio (- ?puntuacio 50))
    else (if (and ?balco (eq ?pBalco -1)) then (bind ?puntuacio (- ?puntuacio 50))))
    (if (< ?puntuacio 0) then return ?puntuacio)

    (bind ?garatge (send ?c get-garatge))
    (if (and (not ?garatge) (eq ?pGaratge 1)) then (bind ?puntuacio (- ?puntuacio 50))
    else (if (and ?garatge (eq ?pGaratge -1)) then (bind ?puntuacio (- ?puntuacio 50))))
    (if (< ?puntuacio 0) then return ?puntuacio)

    (bind ?mascota (send ?c get-mascota))
    (if (and (not ?mascota) (eq ?pMascota 1)) then (bind ?puntuacio (- ?puntuacio 50))
    else (if (and ?mascota (eq ?pMascota -1)) then (bind ?puntuacio (- ?puntuacio 50))))
    (if (< ?puntuacio 0) then return ?puntuacio)

    (return ?puntuacio)
)
