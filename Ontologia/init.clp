(defrule initAndLoad "Load Files"
  ;;hauria de ser amb initial-fact pero no sabem com es fa
  ?trigger <- (initial)
	=>
	(load "ProjectOntologyAprop.clp")
  (load "funcionsImprimir.clp")
  (load "funcionsPreguntes.clp")
  (load "funcionsComprovacions.clp")
  (load "inputRules.clp")
  (assert(initial-main))
)
