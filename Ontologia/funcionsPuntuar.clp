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

  (if ?terrassa then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?garatge then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?piscina then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?piscina then (bind ?punts (+ ?punts ?balco)))

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


  (bind ?punts 0)
  (bind ?puntsGuany 5)
  (bind ?justificacions (create$))

  (if ?aire_condicionat then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?calefaccio then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?electrodomestics then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?moblada then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?solejat then (bind ?punts (+ ?punts ?puntsGuany)))
  (if ?vivenda_amb_vistes then (bind ?punts (+ ?punts ?puntsGuany)))

  ;;justificacio comeditat extra
  (if (> ?punts 0) then
      (bind ?justificacions (insert$ ?justificacions 1 "Te comeditats extres"))
  )

  (bind ?justificacions (insert$ ?justificacions 1 ?punts))
  (return ?justificacions)
)

(deffunction puntuarVivendasegonsLlista
  ( ?vivenda
    ?edat
    ?fills
    ?gentGran
    ?grup_estudiants
    ?Garatge
    ?Balco
    ?Mascota
    ?pllistaPositivaDebil
    ?pllistaNegativaDebil
  )

  (bind ?c (send ?vivenda get-te_car_vivenda))
  (bind ?justificacions(create$))
  (bind ?puntuacio 0)

  (bind ?puntsServei 30)
  (bind ?puntsFillsEscoles 30)
  (bind ?puntsGentGranHospital 30)
  (bind ?puntsGentGranAscensor 30)
  (bind ?puntsJoveOci 30)
  (bind ?puntsGrupTransportPublic 30)
  (bind ?puntsVolCaracteristica 15)
  (bind ?puntsNoVolCaracteristica 15)
  (bind ?puntsServei 30)


  ;;Si te una de les següents Caracteristiques1
  ;;terrassa garatge piscina balco
  (bind ?ze (puntuarZonesExteriors ?vivenda))
  (printout t ?ze crlf)
  ;;Si te una de les següents Caracteristiques2
  ;;aire_condicionat  calefaccio electrodomestics
  ;; moblada solejat vivenda_amb_vistes
  (bind ?cv (puntuarComoditats ?vivenda))
  (printout t ?cv crlf)



  (bind $?serveis (send ?vivenda get-esta_a_prop))
  ;;Mirar si hi ha serveis
  (loop-for-count (?i 1 (length$ $?pllistaPositivaDebil))
      (bind ?curr-servei (nth$ ?i ?pllistaPositivaDebil))
      ;;s'ha trobat el servei?
      (if (not (ServeiAprop ?vivenda ?curr-servei))
        then
          (bind ?puntuacio (+ ?puntuacio ?puntsServei))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "No te un servei de preferencia"))
      )
  )

  (loop-for-count (?i 1 (length$ $?pllistaNegativaDebil))
      (bind ?curr-servei (nth$ ?i ?pllistaPositivaDebil))
      ;;s'ha trobat el servei?
      (if  (ServeiAprop ?vivenda ?curr-servei)
        then
          (bind ?puntuacio (- ?puntuacio ?puntsServei))
          (bind ?index (+ (length$ ?justificacions) 1))
          (bind ?justificacions (insert$ ?justificacions ?index "Te un servei de NO preferencia"))
      )
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

    ;;(bind ?ascensor (send ?c get-ascensor))
    (bind ?ascensor FALSE)
    (bind ?planta (send ?c get-balco))
    (if   (and (> ?planta 1) (not ?ascensor))
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsGentGranAscensor))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Dificil accesibilitat"))
    )
  )

  ;;gent jove
  (if (<= ?edat 30)  then
    (bind ?check (ServeiAprop ?vivenda "oci"))
    (if  ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsJoveOci))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te oci a prop"))
    )
  )


  ;;grup estudiants
  (if ?grup_estudiants  then
    (bind ?check (ServeiAprop ?vivenda "oci"))
    (if ?check
      then
        (bind ?puntuacio (+ ?puntuacio ?puntsGrupTransportPublic))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Te transport public proper"))
    )
  )

  ;;Caracteristiques
  ;;Balco
  (bind ?Vbalco (send ?c get-balco))
  (if ?Balco
    then
      (if ?Vbalco then
        (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Prefereix garatge i en en te"))
      )
    else
      (if (not ?Vbalco) then
        (bind ?puntuacio (- ?puntuacio ?puntsVolCaracteristica))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "No prefereix garatge i la vivenda en disposa"))
      )
  )

  ;;Garatge
  (bind ?Vgaratge (send ?c get-garatge))
  (if ?Garatge
    then
      (if ?Vgaratge then
        (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Prefereix balco i en en te"))
      )
    else
      (if (not ?Vgaratge) then
        (bind ?puntuacio (- ?puntuacio ?puntsVolCaracteristica))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "No prefereix  balco  i la vivenda en disposa"))
      )
  )

  ;;mascotes
  (bind ?Vmascota (send ?c get-mascota))
  (if ?Mascota
    then
      (if ?Vmascota then
        (bind ?puntuacio (+ ?puntuacio ?puntsVolCaracteristica))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "Prefereix mascota i en en te"))
      )
    else
      (if (not ?Vmascota) then
        (bind ?puntuacio (- ?puntuacio ?puntsVolCaracteristica))
        (bind ?index (+ (length$ ?justificacions) 1))
        (bind ?justificacions (insert$ ?justificacions ?index "No prefereix  mascota i la vivenda en deixa"))
      )
  )

  (bind ?justificacions (insert$ ?justificacions 1 ?puntuacio))
  (return ?justificacions)
)
