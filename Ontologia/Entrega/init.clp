(defrule initAndLoad "Load Files"
  ?trigger <- (initial)
	=>
	(load "ProjectOntology.clp")
  (load "funcionsImprimir.clp")
  (load "funcionsPreguntes.clp")
  (load "funcionsComprovacions.clp")
  (load "funcionsPuntuar.clp")
  (load "inputRules.clp")
)
