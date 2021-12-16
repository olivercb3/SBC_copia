;;;-------------------------------PREGUNTAS-------------------------------------


;;; Pregunta de si o no
(deffunction preguntaBinaria (?text)
  (printout t  ?text " (si/no):" crlf)
  (bind ?r (read))
  (while (not (or
                (eq ?r si) (eq ?r no)))
      (printout t "Resposta invalida a de ser  si o no" crlf)
        (bind ?r (read))
      )
  (if  (eq ?r si)
    then TRUE
    else FALSE
  )
)

;; Pregunta segur(si/no), (si/no), indiferent

;;les seguentes dues linies han d'anar al main

;;(bind ?valorsPermesosBinari (create$ "Segur si" "Si" "Indiferent" "No" "Segur no"))      -    definim valors possibles
;;(bind ?pBalco (preguntaBinariaBis "Vols balco?" ?valorsPermesosBinari))           -       preguntem i obtenim resultat


(deffunction preguntaBinariaBis (?text $?valors-permesos)
    (progn$
    (?var ?valors-permesos)
    (lowcase ?var))
  (format t "¿%s? (%s) " ?text (implode$ ?valors-permesos))
  (bind ?r (read))
  (while (not (member (lowcase ?r) ?var)) do
    (format t "¿%s? (%s) " ?text (implode$ ?valors-permesos))
    (bind ?r (read))
  )
  ;;afegir la gestio de retorn (2...-2)
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


;;; Pregunta de qualsevol tipus
(deffunction preguntaVariable (?text)
	(format t "%s" ?text)
	(bind ?r (read))
  ?r
)
