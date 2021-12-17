;;;-------------------------------PREGUNTAS-------------------------------------


;; Pregunta segur(si/no), (si/no), indiferent
(deffunction preguntaBinariaBis (?text $?valors-permesos)
  (format t "%s (%s) " ?text (implode$ ?valors-permesos))
  (printout t crlf)
  (bind ?r (readline))
  (bind ?r (str-cat ?r))
  (while (not (member$ (lowcase ?r) ?valors-permesos)) do
    (format t "¿%s? (%s) " ?text (implode$ ?valors-permesos))
    (printout t crlf)
    (bind ?r (readline))
  )
  (if (eq (str-compare "segur si" ?r) 0)
    then (bind ?resp 2)
    else
      (if (eq (str-compare "si" ?r) 0)
        then (bind ?resp 1)
        else
          (if (eq (str-compare "indiferent" ?r) 0)
            then (bind ?resp 0)
            else
              (if (eq (str-compare "no" ?r) 0)
                then (bind ?resp -1)
                else
                  (bind ?resp -2)
              )
          )
      )
    )
    ?resp
)

;;; Pregunta per un integer
(deffunction preguntaInteger (?text ?min ?max)
	(printout t crlf)
	(printout t ?text crlf)
	(bind ?r (read))
	(while (not(and(>= ?r ?min)(<= ?r ?max))) do
    (printout t "Numero invalid a de estar entre " ?min " i " ?max crlf)
		(bind ?r (read))
	)
	?r
)


;; Pregunta integer bis
(deffunction preguntaIntegerBis (?text ?min ?max)
	(format t "%s" ?text)
  (printout t crlf)
	(bind ?r (readline))
  (bind ?resp (explode$ ?r))

  (printout t (nth$ 1 ?resp))

  (while (or(and(> (length$ ?resp) 1)(neq (lowcase (nth$ 1 ?resp)) segur)(>= (integer(nth$ 2 ?resp)) ?min)(<= (integer(nth$ 2 ?resp)) ?max)) (and(< (length$ ?resp) 1)(neq (lowcase (nth$ 1 ?resp)) indiferent)) (and(= (length$ ?resp) 1)(>= (integer(nth$ 1 ?resp)) ?min)(<= (integer(nth$ 2 ?resp)) ?max)))
    do
    (format t "%s (opcions: segur seguit d'un numero, numero o indiferent)" ?text)
    (printout t crlf)
    (bind ?r (readline))
    (bind ?resp (explode$ ?r))
  )
  ?resp
)

;;; Pregunta de qualsevol tipus
(deffunction preguntaVariable (?text)
	(format t "%s" ?text)
	(bind ?r (read))
  ?r
)
