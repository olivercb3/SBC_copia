(deffunction ServeiAprop (?v ?s)
  (bind $?serveis (send ?v get-esta_a_prop))
  ;;Mirar si hi ha serveis
  (bind ?found FALSE)
  (loop-for-count (?i 1 (length$ $?serveis))
      (bind ?serveiViv (nth$ ?i ?serveis))
      (bind ?found (acceptableServei ?s ?serveiViv))
      (if ?found then (break))
  )
  ;;s'ha trobat el servei?
  (return ?found)
)


(deffunction puntuarZonesExteriors (?v)
  (bind ?c (send ?v get-te_car_vivenda))
  (bind ?terrassa (send ?c get-terrassa))
  (bind ?garatge (send ?c get-garatge))
  (bind ?piscina (send ?c get-piscina))
  (bind ?balco (send ?c get-balco))

  (bind ?punts 0)
  (bind ?puntsGuany 7)
  (bind ?justificacions (create$))

  (if ?terrassa then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?garatge then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?piscina then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?balco then (bind ?punts (+ ?punts ?puntsGuany)))

  ;;justificacio zones exteriors
  (if (> ?punts 0) then
      (bind ?justificacions
          (insert$ ?justificacions 1 "Te zones exteriors"))
  )

  (bind ?justificacions (insert$ ?justificacions 1 ?punts))
  (return ?justificacions)
)

(deffunction puntuarComoditats (?v)
  (bind ?c (send ?v get-te_car_vivenda))
  (bind ?aire_condicionat (send ?c get-aire_condicionat))
  (bind ?calefaccio (send ?c get-calefaccio))
  (bind ?electrodomestics (send ?c get-electrodomestics))
  (bind ?moblada (send ?c get-moblada))
  (bind ?solejat (send ?c get-solejat))
  (bind ?vivenda_amb_vistes (send ?c get-vivenda_amb_vistes))

  (bind ?justificacions (create$))

  (bind ?punts 0)
  (bind ?puntsGuany 5)
  (bind ?justificacions (create$))

  (if ?aire_condicionat then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?calefaccio then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?electrodomestics then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?moblada then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?solejat then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?vivenda_amb_vistes then (bind ?punts (+ ?punts ?puntsGuany)))

  ;;justificacio comoditat extra
  (if (> ?punts 0) then
      (bind ?justificacions (insert$ ?justificacions 1 "Te comoditats extres"))
  )

  (bind ?justificacions (insert$ ?justificacions 1 ?punts))
  (return ?justificacions)
)

(deffunction puntuarVivenda (?vivenda ?edat
				      ?fills
				      ?gentGran
				      ?pnumHab
				      ?pPreuMax
				      ?pPreuMin
				      ?pSupMax
				      ?pSupMin
				      ?pGaratge
				      ?pBalco
				      ?pMascota
				      ?pllistaPositivaDebil
				      ?pllistaNegativaDebil)
    (bind ?c (send ?vivenda get-te_car_vivenda))

    (bind ?justificacions (create$))

    ;mirem restriccions debils

    (bind ?puntuacio 100)

    (bind ?preu (send ?c get-preu))
    (if (or (> ?preu ?pPreuMax) (< ?preu ?pPreuMin)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?just "El preu no esta dins del rang especificat")
      (bind ?justificacions (insert$ ?justificacions ?index ?just))
    )

    (bind ?superficie (send ?c get-superficie))
    (if (or (> ?superficie ?pSupMax) (< ?superficie ?pSupMin)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?just "La superficie no esta dins del rang especificat")
      (bind ?justificacions (insert$ ?justificacions ?index ?just))
    )

    (bind ?hab (send ?c get-num_dormitoris))
    (if (neq ?hab ?pnumHab) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?just "Les habitacions no son les demanades")
      (bind ?justificacions (insert$ ?justificacions ?index ?just))
    )

    (bind $?serveis (send ?vivenda get-esta_a_prop))
    (loop-for-count (?i 1 (length$ $?pllistaPositivaDebil))
        (bind ?curr-servei (nth$ ?i ?pllistaPositivaDebil))
        (bind ?found FALSE)
        (loop-for-count (?i 1 (length$ $?serveis))
            (bind ?serveiViv (nth$ ?i ?serveis))
            (bind ?found (acceptableServei ?curr-servei ?serveiViv))
            (if ?found then (break))
        )
        ;;s'ha trobat el servei?
        (if (not ?found)
          then
            (bind ?puntuacio (- ?puntuacio 50))
            (bind ?index (+ (length$ ?justificacions) 1))
            (bind ?just (str-cat "No disposa del servei " ?curr-servei " que vols"))
            (bind ?justificacions (insert$ ?justificacions ?index ?just))
        )
    )

    (if (< ?puntuacio 0) then
      (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))
      (return ?justificacions)
    )

    (loop-for-count (?i 1 (length$ $?pllistaNegativaDebil))
        (bind ?curr-servei (nth$ ?i ?pllistaNegativaDebil))
        (bind ?found FALSE)
        (loop-for-count (?i 1 (length$ $?serveis))
            (bind ?serveiViv (nth$ ?i ?serveis))
            (bind ?found (acceptableServei ?curr-servei ?serveiViv))
            (if ?found then (break))
        )
        ;;s'ha trobat el servei?
        (if ?found
          then (bind ?puntuacio (- ?puntuacio 50))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?just (str-cat "Te el servei " ?curr-servei " que no vols"))
          (bind ?justificacions (insert$ ?justificacions ?index ?just))
        )
    )

    (if (< ?puntuacio 0) then
      (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))
      (return ?justificacions)
    )

    (bind ?balco (send ?c get-balco))
    (if (and (not ?balco) (eq ?pBalco 1)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index "NO Te balco i en vol"))
    )
    (if (and ?balco (eq ?pBalco -1)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index "Te balco i no el vol"))
    )
    (if (< ?puntuacio 0) then (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))(return ?justificacions))
    (bind ?garatge (send ?c get-garatge))
    (if (and (not ?garatge) (eq ?pGaratge 1)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index "NO Te garatege i en vol"))
    )
    (if (and ?garatge (eq ?pGaratge -1)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index "Te garatege i no el vol")))
    (if (< ?puntuacio 0) then (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))(return ?justificacions))

    (bind ?mascota (send ?c get-mascota))
    (if (and (not ?mascota) (eq ?pMascota 1)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index "NO te mascota i en vol"))
    )
    (if (and ?mascota (eq ?pMascota -1)) then
      (bind ?puntuacio (- ?puntuacio 50))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index "Te mascota i no el vol"))
    )
    (if (< ?puntuacio 100) then (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))(return ?justificacions))

    (bind ?puntsFillsEscoles 30)
    (bind ?puntsGentGranHospital 30)
    (bind ?puntsGentGranAscensor 30)
    (bind ?puntsJoveOci 30)
    (bind ?puntsVolCaracteristica 15)
    (bind ?puntsNoVolCaracteristica 15)
    (bind ?puntsServeisGenerals 20)
    (bind ?puntsZvMascota 10)

    ;;Si te una de les següents Caracteristiques1
    ;;terrassa garatge piscina balco
    (bind ?ze (puntuarZonesExteriors ?vivenda))

    (bind ?punts (nth$ 1 ?ze))
    (if (> ?punts 0) then
      (bind ?just (nth$ 2 ?ze))
      (bind ?puntuacio (+ ?puntuacio ?punts))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index ?just))
    )

    ;;Si te una de les següents Caracteristiques2
    ;;aire_condicionat  calefaccio electrodomestics
    ;; moblada solejat vivenda_amb_vistes
    (bind ?cv (puntuarComoditats ?vivenda))

    (bind ?punts (nth$ 1 ?cv))
    (if (> ?punts 0) then
      (bind ?just (nth$ 2 ?cv))
      (bind ?puntuacio (+ ?puntuacio ?punts))
      (bind ?index (+ (length$ ?justificacions) 1))
      (bind ?justificacions (insert$ ?justificacions ?index ?just))
    )

    (bind ?check (ServeiAprop ?vivenda "zonesverdes"))
    (if ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsServeisGenerals))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te zones verdes a prop"))
    )

    (bind ?check (ServeiAprop ?vivenda "transportpublic"))
    (if ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsServeisGenerals))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te transport public a prop"))
    )

    (bind ?check (ServeiAprop ?vivenda "centresalut"))
    (if ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsServeisGenerals))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te un centre de salut a prop"))
    )

    (bind ?check (ServeiAprop ?vivenda "mercat"))
    (if ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsServeisGenerals))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te un mercat a prop"))
    )

  ;;fills
  (if (> ?fills 0) then
    (bind ?check (ServeiAprop ?vivenda "escoles"))
    (if   ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsFillsEscoles))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te un servei de NO preferencia"))
    )
  )

  ;;Gent gran
  (if (or (>= ?edat 65) (> ?gentGran 0) ) then
    (bind ?check (ServeiAprop ?vivenda "centresalut"))
    (if  ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsGentGranHospital))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te un centre de salut proper"))
    )

    (bind ?ascensor (send ?c get-ascensor))

    (bind ?planta (send ?c get-planta))
    (if   (not (and (> ?planta 1) (not ?ascensor)))
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsGentGranAscensor))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Facil acces per la gent gran"))
    )
  )

    ;;gent jove
    (if (<= ?edat 30)  then
      (bind ?check (ServeiAprop ?vivenda "oci"))
      (if ?check
        then
          (bind ?puntuacio (+ ?puntuacio ?puntsJoveOci))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "Te oci a prop"))
      )
    )

  ;;Caracteristiques
    ;;Balco
    (bind ?Vbalco (send ?c get-balco))
    (if (eq ?pBalco 1)
      then
        (if ?Vbalco then
          (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "Prefereix balco i en en te"))
        )
    )
    (if (eq ?pBalco -1)
      then
        (if (not ?Vbalco) then
          (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "No prefereix balco i la vivenda no en disposa"))
        )
    )

    ;;Garatge
    (bind ?Vgaratge (send ?c get-garatge))
    (if (eq ?pGaratge 1)
      then
        (if ?Vgaratge then
          (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "Prefereix garatge i en en te"))
        )
    )
    (if (eq ?pGaratge -1)
      then
        (if (not ?Vgaratge) then
          (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "No prefereix garatge i la vivenda no en disposa"))
        )
    )

    ;;mascotes
    (bind ?Vmascota (send ?c get-mascota))
    (if (eq ?pMascota 1)
      then
        (if ?Vmascota then
          (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "Prefereix mascota i en en te"))
        )
    )
    (if (eq ?pMascota -1)
      then
        (if (not ?Vmascota) then
          (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "No prefereix  mascota i la vivenda no en deixa"))
        )
    )

    (if (or (eq ?pMascota 1)(eq ?pMascota 2))
      then
        (bind ?check (ServeiAprop ?vivenda "zonesverdes"))
        (if ?check
          then
            (bind ?puntuacio (+ ?puntuacio ?puntsZvMascota))
            (bind ?index (+ (length$ ?justificacions) 1))
            (bind ?justificacions (insert$ ?justificacions ?index "Te zones verdes a prop, ideal per a les mascotes"))
        )
    )

    (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))
    (return ?justificacions)
)
